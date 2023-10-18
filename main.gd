extends Node

@export var crawler_scene: PackedScene
@export var heart_scene: PackedScene
@export var shot_speed_up_scene: PackedScene
@export var times_3_scene: PackedScene
@export var dead_crawler_scene: PackedScene
var stage
var character

func _ready():
	new_game()

func game_over():
	$MobTimer.stop()

func new_game():
	character = $Player.get_child(0)
	character.position = Vector2(100, 100)
	character.health = 3
	stage = $MapNode.get_child(0)
	$MobTimer.start()


func _on_player_player_dead():
	game_over()
	new_game()



func _on_mob_timer_timeout():
	var crawler = crawler_scene.instantiate()
	
	var crawler_spawn_path = stage.get_child(0)
	var crawler_spawn_location = crawler_spawn_path.get_child(0)
	crawler_spawn_location.progress_ratio = randf()
	
	crawler.position = crawler_spawn_location.position
	
	add_child(crawler)
	
func _on_pie_heart_spawn(args):
	var pos = args
	var heart = heart_scene.instantiate()
	heart.position = pos
	call_deferred("add_child", heart)
	
func _on_pie_speed_spawn(args):
	var pos = args
	var speed = shot_speed_up_scene.instantiate()
	speed.position = pos
	call_deferred("add_child", speed)

func _on_pie_tri_spawn(args):
	var pos = args
	var tri = times_3_scene.instantiate()
	tri.position = pos
	call_deferred("add_child", tri)

func _on_pie_dead_crawler(args):
	var pos = args
	var dedcra = dead_crawler_scene.instantiate()
	dedcra.position = pos
	call_deferred("add_child", dedcra)
