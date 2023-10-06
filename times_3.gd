extends Area2D

signal trishot

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.is_in_group("Clown"):
		connect("trishot", body._on_times_3_trishot)
		emit_signal("trishot")
		queue_free()
