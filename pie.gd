extends Area2D

@onready var splotion = preload("res://piesplotion.tscn")

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_body_entered(body):
	if body.is_in_group("crawler"):
		body.queue_free()
	var splotion_instance = splotion.instantiate()
	get_tree().root.add_child(splotion_instance)
	splotion_instance.transform = self.global_transform
	queue_free()
	

