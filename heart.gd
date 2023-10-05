extends Area2D

signal health_up

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.is_in_group("Clown"):
		connect("health_up", body._on_heart_health_up)
		emit_signal("health_up")
		queue_free()
