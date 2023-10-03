extends CharacterBody2D

var is_idle = false
var is_run = false
var is_hit = false
var is_throw = false
var is_dance = false

@export var health = 3

@export var speed = 200

signal shoot
signal hit_detected
signal dead

func _process(delta):
	if is_throw: $AnimationPlayer.play("Simple/Throw")
	elif is_dance: $AnimationPlayer.play("Simple/Dance")
	# elif is_hit $AnimationPlayer.play()
	elif is_run: $AnimationPlayer.play("Simple/Run")
	elif is_idle:  $AnimationPlayer.play("Partial/Idle")
	
	if Input.is_action_pressed("shoot"):
		emit_signal("shoot")

func get_input():
	var input_direction = Input.get_vector("leftWalk", "rightWalk", "upWalk", "downWalk")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	
	if !is_throw:
		if velocity == Vector2.ZERO:
			is_run = false
			is_idle = true
		else:
			is_run = true
			is_idle = false
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("crawler"):
			emit_signal("hit_detected")


func _on_player_clown_hit():
	health = health -1
	if health < 0:
		emit_signal("dead")


func _on_player_start_throw():
	is_throw = true


func _on_player_stop_throw():
	is_throw = false
