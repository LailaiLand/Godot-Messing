extends Area2D

var speed = 750
var biter = null

signal heart_spawn
signal speed_spawn
signal tri_spawn
signal dead_crawler
@onready var splotion = preload("res://piesplotion.tscn")
#@onready var heart_scene = preload("res://heart.tscn")

func _ready():
	print("pewpews")
	var parent = get_parent()
	if parent.has_node("Biter"):
		biter = parent.get_node("Biter")
	connect("heart_spawn", parent._on_pie_heart_spawn)
	connect("speed_spawn", parent._on_pie_speed_spawn)
	connect("tri_spawn", parent._on_pie_tri_spawn)
	connect("dead_crawler", parent._on_pie_dead_crawler)
	
	rotation += randf_range(-PI * 0.15 , PI * 0.15)

func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_body_entered(body):
	#TODO: Add func in biter to clear crawler and call it there
	if body.is_in_group("crawler"):
		if biter:
			if biter.enemy_stack.has(body):
				biter.enemy_stack.erase(body)
		_random_heart_spawn()
		emit_signal("dead_crawler", body.position)
		body.queue_free()
		
	var splotion_instance = splotion.instantiate()
	get_tree().root.add_child(splotion_instance)
	splotion_instance.transform = self.global_transform
	queue_free()

func _random_heart_spawn():
	var random_num = randf_range(0, 1)
	if random_num <= 0.1:
		_random_item()

func _random_item():
	var random_num = randi_range(1, 3)
	if random_num == 1:
		emit_signal("heart_spawn", position)
	elif random_num == 2:
		emit_signal("speed_spawn", position)
	elif random_num == 3:
		emit_signal("tri_spawn", position)

func _handle_biter_enemy_stack(object):
	if biter.enemy_stack.has(object):
		biter.enemy_stack.erase(object)
