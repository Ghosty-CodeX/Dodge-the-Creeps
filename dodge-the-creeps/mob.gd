extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_type = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_type.pick_random()
	$AnimatedSprite2D.play()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() #will delete the node at the end of the frame
