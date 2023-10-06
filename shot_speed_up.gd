extends Area2D

signal shot_speed_up

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.is_in_group("Clown"):
		connect("shot_speed_up", body._on_shot_speed_up_shot_speed_up)
		emit_signal("shot_speed_up")
		queue_free()
