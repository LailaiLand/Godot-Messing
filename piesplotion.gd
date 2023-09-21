extends AnimatedSprite2D
@onready var foil = preload("res://tin.tscn")

func _ready():
	play()

func _on_animation_finished():
	var foil_instance = foil.instantiate()
	get_tree().root.add_child(foil_instance)
	foil_instance.transform = self.global_transform
	queue_free()
