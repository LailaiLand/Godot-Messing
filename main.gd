extends Node

@export var crawler_scene: PackedScene
@export var heart_scene: PackedScene
@export var shot_speed_up_scene: PackedScene
@export var times_3_scene: PackedScene
@export var dead_crawler_scene: PackedScene
@export var poop_scene: PackedScene
@export var biter_scene: PackedScene

@export var castle_scene: PackedScene
@export var cross_scene: PackedScene
@export var spiral_scene: PackedScene
@export var demo_scene: PackedScene

var stage = null
var character
var biter = null
var maps = []
var map_index = 0
var is_paused
var poop_pile = []

func _ready():
	maps.push_back(castle_scene)
	maps.push_back(cross_scene)
	maps.push_back(spiral_scene)
	maps.push_back(demo_scene)
	character = $Player.get_child(0)
	$PauseMenu.ready_hook()
	get_tree().paused = true
	is_paused = true
	print("on ready pause status: ", get_tree().paused)
	new_game()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_open_pause()

func game_over():
	var mob_group = get_tree().get_nodes_in_group("crawler")
	for mob in mob_group:
		_check_biter_stack(mob)
		remove_child(mob)
	for poop in poop_pile:
		remove_child(poop)
	$MobTimer.stop()

func new_game():
	character.position = Vector2(100, 100)
	character.health = 3
	character.is_dance = false
	if stage != null:
		stage.queue_free()
	delete_biter()
	stage = maps[map_index].instantiate()
	$MapNode.add_child(stage)
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

func _on_Biter_spawn_poop(args):
	var pos = args
	var poop = poop_scene.instantiate()
	poop.position = pos
	poop_pile.push_back(poop)
	call_deferred("add_child", poop)

func _on_Biteify_spawn_biter(args):
	var pos = args
	var biter_instance = biter_scene.instantiate()
	biter_instance.position = pos
	biter = biter_instance
	call_deferred("add_child", biter_instance)
	print(biter.name)

func _on_child_delete_crawler(childNode, is_pie):
	if !_check_biter_stack(childNode) and !is_pie:
		return
	remove_child(childNode)

func _check_biter_stack(crawler):
	if biter == null:
		return false
	var biter_stack = biter.enemy_stack
	if !biter_stack.has(crawler):
		return false
	biter_stack.erase(crawler)
	return true

func _on_castle_victory():
	character.is_dance = true
	delete_biter()
	game_over()

func delete_biter():
	if biter != null:
		biter.queue_free()


func _on_pause_menu_select_close():
	if is_paused:
		$PauseMenu.visible = false
		get_tree().paused = false
		is_paused = false

func _on_pause_menu_select_new_game(index):
	$PauseMenu.visible = false
	map_index = index
	get_tree().paused = false
	game_over()
	new_game()

func _open_pause():
	if !is_paused:
		get_tree().paused = true
		$PauseMenu.visible = true
		is_paused = true
	else:
		_on_pause_menu_select_close()
