extends Area2D
signal hit

@export var speed = 400 #how fast the player will move, The Export keyword allows us to set its value in the inspector
var screen_size #Size of the game window

func _ready():
	screen_size = get_viewport_rect().size #will find the size of the game window.
	hide() #hides the player when the game starts

func _process(delta): #delta parameter refers to the frame length - the amount of time that the previous frame took to complete
	var velocity = Vector2.ZERO #Player movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		#Joystick functionality
	if Input.is_action_pressed("move_right_joystick"):
		velocity.x += 1
	if Input.is_action_pressed("move_left_joystick"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down_joystick"):
		velocity.y += 1
	if Input.is_action_pressed("move_up_joystick"):
		velocity.y -= 1
	#contoller D-pad functionality
	if Input.is_action_pressed("move_right_dpad"):
		velocity.x += 1
	if Input.is_action_pressed("move_left_dpad"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down_dpad"):
		velocity.y += 1
	if Input.is_action_pressed("move_up_dpad"):
		velocity.y -= 1
		
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #clamp() will prevent the player from moving off the screen 
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D): #Green icon on the left indicates a singal is connected
	hide() #player will disappear after being hit
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) #will disable player collision, deferred tells godot engine to wait until safe to do so

func start(pos): #Function to reset the game
	position = pos
	show()
	$CollisionShape2D.disabled = false
