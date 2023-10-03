extends Node2D

@onready var projectile = preload("res://pie.tscn")
var aim_direction = Vector2.ZERO
var cooldown = false
var is_hit = false
signal shot_fired
signal start_dance
signal stop_dance
signal start_throw
signal stop_throw
signal clown_hit

func _process(_delta):
	aim_direction = Input.get_vector("leftAim", "rightAim", "upAim", "downAim").angle()
	$Shooter/AimingMarkers/Origin.rotation = aim_direction
	

func _on_shooter_shoot():
	if !cooldown:
		var projectile_instance = projectile.instantiate()
		owner.add_child(projectile_instance)
		projectile_instance.transform = $Shooter/AimingMarkers/Origin.global_transform
		cooldown = true
		emit_signal("start_throw")
		emit_signal("shot_fired")


func _on_shot_timer_timeout():
	emit_signal("stop_throw")
	cooldown = false

func _on_shooter_hit_detected():
	if !is_hit:
		is_hit = true
		emit_signal("clown_hit")

func _on_hit_timer_timeout():
	is_hit = false



#func _on_shooter_flip():
	#$Shooter.scale.x = -0.35
