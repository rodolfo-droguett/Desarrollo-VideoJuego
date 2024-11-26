extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
# Replace with function body.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()
	$ScoreTimer.start()
	$MobTimer.start()
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():

	var mob = mob_scene.instantiate()

	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	var direction = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity	

	add_child(mob)
	print("Mob instanciado")
	


func _on_hud_start_game() -> void:
	pass # Replace with function body.
	
	
