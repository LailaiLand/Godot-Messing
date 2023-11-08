extends CharacterBody2D

var enemy_stack = []
var object_pos
var target_pos
var shooter
var speed = 200
var flip = false
var eating = false
var main_scene

signal spawn_poop
signal delete_crawler

func _ready():
	shooter = get_parent().get_child(1).get_child(0)
	$AnimatedSprite2D.play("stand")
	main_scene = get_parent()
	connect("spawn_poop", main_scene._on_Biter_spawn_poop)
	connect("delete_crawler", main_scene._on_child_delete_crawler)

func _process(_delta):
	if flip:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	if $AnimatedSprite2D.animation == "bite":
		if $AnimatedSprite2D.get_frame() == 10:
			$AnimatedSprite2D.play("stand")
			emit_signal("spawn_poop", position)
			eating = false
		

func _physics_process(_delta):
	_check_stack_validity()
	if !enemy_stack.is_empty():
		enemy_stack.sort_custom(sort_closest)
		object_pos = enemy_stack[0].position
	else:
		object_pos = shooter.position
	target_pos = (object_pos - position).normalized()
	
	velocity = target_pos * speed
	if velocity.x > 1:
		flip = false
	elif velocity.x < 1:
		flip = true
	
	if !eating:
		move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("crawler"):
			_eat(collision.get_collider())


func sort_closest(a, b):
		return a.position.distance_to(position) < b.position.distance_to(position)

func _on_case_zone_body_entered(body):
	if body.is_in_group("crawler"):
		enemy_stack.push_back(body)

func _eat(food):
	eating = true
	$AnimatedSprite2D.play("bite")
	emit_signal("delete_crawler", food, false)

func _clear_stack():
	enemy_stack.clear()

func _check_stack_validity():
	for i in enemy_stack:
		if !main_scene.get_children().has(i):
			enemy_stack.erase(i)
