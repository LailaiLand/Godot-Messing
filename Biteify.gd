extends Area2D

var hover_range = 20
var hover_current = 0
var hover_flip = false
var rotation_speed = 0.03

signal spawn_biter

func _ready():
	$Radience.play()
	var main_scene = get_tree().get_root().get_node("Main")
	connect("spawn_biter", main_scene._on_Biteify_spawn_biter)

func _process(delta):
	floating_animation()

func floating_animation():
	if hover_current > hover_range:
		hover_flip = true
	if hover_current < 0:
		hover_flip = false
	if !hover_flip:
		position.y = position.y - 1
		hover_current = hover_current + 1
	else:
		position.y = position.y + 1
		hover_current = hover_current - 1
	rotation += rotation_speed
	
	


func _on_body_entered(body):
	if body.is_in_group("Clown"):
		emit_signal("spawn_biter", position)
		queue_free()
