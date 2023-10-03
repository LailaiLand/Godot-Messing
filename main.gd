extends Node

@export var crawler_scene: PackedScene

func _ready():
	new_game()

func game_over():
	$MobTimer.stop()

func new_game():
	$Player/Shooter.position = Vector2(100, 100)
	$Player/Shooter.health = 3
	$MobTimer.start()


func _on_player_player_dead():
	game_over()
	new_game()



func _on_mob_timer_timeout():
	var crawler = crawler_scene.instantiate()
	
	var crawler_spawn_location = get_node("MobPath/MobSpawnLocation")
	crawler_spawn_location.progress_ratio = randf()
	
	crawler.position = crawler_spawn_location.position
	
	add_child(crawler)
	

