extends CharacterBody2D

var player
var player_position
var speed = 150

func _ready():
	$AnimatedSprite2D.play("walk")
	var main_scene = get_tree().get_root().get_node("Main")
	player = main_scene.get_node("Player").get_child(0)

func _physics_process(delta):
	player_position = player.position
	velocity = position.direction_to(player_position) * speed
	
	move_and_slide()
