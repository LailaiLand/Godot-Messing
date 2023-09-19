extends Node2D

@onready var projectile = preload("res://pie.tscn")
var aim_direction = Vector2.ZERO

func _process(_delta):
	aim_direction = Input.get_vector("leftAim", "rightAim", "upAim", "downAim").angle()
	$Shooter/AimingMarkers/Origin.rotation = aim_direction

func _on_shooter_shoot():
	var projectile_instance = projectile.instantiate()
	owner.add_child(projectile_instance)
	projectile_instance.transform = $Shooter/AimingMarkers/Origin.global_transform
