extends CharacterBody2D

var enemy_stack = []
var object_pos
var target_pos
var shooter
var speed = 200
var flip = false
var is_eating = false

signal spawn_poop

func _ready():
	shooter = get_parent().get_child(1).get_child(0)
	$AnimatedSprite2D.play("stand")
	var main_scene = get_parent()
	connect("spawn_poop", main_scene._on_Biter_spawn_poop)

func _process(delta):
	if flip:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _physics_process(delta):
	if enemy_stack.is_empty():
		object_pos = shooter.position
	else:
		enemy_stack.sort_custom(sort_closest)
		object_pos = enemy_stack[0].position
	
	target_pos = (object_pos - position).normalized()
	if is_eating:
		velocity = Vector2.ZERO
	else:
		velocity = target_pos * speed
	if velocity.x < 0:
		flip = true
	elif velocity.x > 0:
		flip = false
	
	if position.distance_to(object_pos) > 10:
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

func _eat(object):
	$AnimatedSprite2D.play("bite")
	is_eating = true
	object.queue_free()

func _on_animated_sprite_2d_animation_finished():
	if is_eating:
		$AnimatedSprite2D.play("stand")
		is_eating = false
		emit_signal("spawn_poop", position)
