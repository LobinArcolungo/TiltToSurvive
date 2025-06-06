extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_tree().call_group("enemies","update_direction",$PlayerArea/Player.position)
	
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	get_tree().call_group("mobs","queue_free")
	
	$HUD.show_game_over()
	
func new_game():
	score=0
	$PlayerArea/Player.start($PlayerArea/StartPostition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#var direction = mob_spawn_location.rotation +PI/2
	
	mob.position = mob_spawn_location.position
	var direction = Vector2($PlayerArea/Player.position-mob_spawn_location.position).normalized().angle()
	 
	#direction += randf_range(-PI/4,PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_score_timer_timeout():
	score+=1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$PlayerArea._draw()
