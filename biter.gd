extends CharacterBody2D

var enemy_stack = []
var object_pos
var target_pos
var shooter
var speed = 200
var flip = false
var eating = false

signal spawn_poop

func _ready():
	shooter = get_parent().get_child(1).get_child(0)
	$AnimatedSprite2D.play("stand")
	var main_scene = get_parent()
	connect("spawn_poop", main_scene._on_Biter_spawn_poop)

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
	if !enemy_stack.is_empty():
		enemy_stack.sort_custom(sort_closest)
		object_pos = enemy_stack[0].position
	else:
		object_pos = shooter.position
	target_pos = (object_pos - position).normalized()
	
	velocity = target_pos * speed
	if velocity.x > 0:
		flip = false
	elif velocity.x < 0:
		flip = true
	
	if !eating:
		move_and_slide()

	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if collision.is_in_group("crawler"):
			_eat(collision)

func sort_closest(a, b):
		return a.position.distance_to(position) < b.position.distance_to(position)

func _on_case_zone_body_entered(body):
	if body.is_in_group("crawler"):
		enemy_stack.push_back(body)

func _eat(food):
	eating = true
	$AnimatedSprite2D.play("bite")
	enemy_stack.erase(food)
	get_parent().remove_child(food)

func _clear_stack():
	enemy_stack.clear()

