extends Area2D

signal gem_collected

func _ready():
	var parent = get_parent()
	connect("gem_collected", parent._on_pyramid_gem_collected)
	$AnimatedSprite2D.play("default")


func _on_body_entered(body):
	if body.is_in_group("Clown"):
		emit_signal("gem_collected")
		queue_free()
