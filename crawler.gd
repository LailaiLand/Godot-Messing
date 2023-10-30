extends CharacterBody2D

var player
var player_position

var speed = 150

func _ready():
	$AnimatedSprite2D.play("walk")
	player = get_parent().get_node("Player").get_child(0)

func _physics_process(delta):
	player_position = player.position
	
	velocity = position.direction_to(player_position) * speed
	
	
	move_and_slide()
