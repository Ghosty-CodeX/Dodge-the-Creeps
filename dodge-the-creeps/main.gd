extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate() #creates a new instance of the mob scene
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf() #chooses a random location on Path2d
	
	mob.position = mob_spawn_location.position #sets mobs position to random location
	
	var direction = mob_spawn_location.rotation + PI / 2 #Set the mobs direction perpendicular to the path direction
	
	direction += randf_range(-PI / 4, PI / 4) #Add some randomness to the direction
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) #Choose the velocity for the mob
	mob.linear_velocity = velocity.rotated(direction)
	
	#spawn the mob by adding it into the main scene
	add_child(mob)
	
	$HUD.update_score(score)


func _on_score_timer_timeout() -> void:
	score += 1


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
