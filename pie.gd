extends Area2D

@onready var splotion = preload("res://piesplotion.tscn")

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_body_entered(body):
	print("entered", body.name)
	if body.name == "Crawler":
		body.queue_free()
	var splotion_instance = splotion.instantiate()
	owner.owner.add_child(splotion_instance)
	queue_free()

