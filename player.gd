extends Node2D

@onready var projectile = preload("res://pie.tscn")
var aim_direction = Vector2.ZERO
var cooldown = false
var is_hit = false
var flashing = false
var rapid_shot = false
var tri_shot = false

var rapid_upgrade = 0
var tri_upgrade = 0

signal flash
signal shot_fired
signal rapid_shot_fired
signal start_dance
signal stop_dance
signal start_throw
signal stop_throw
signal clown_hit
signal player_dead

func _process(_delta):
	aim_direction = Input.get_vector("leftAim", "rightAim", "upAim", "downAim").angle()
	$Shooter/AimingMarkers/Origin.rotation = aim_direction
	if flashing:
		$Shooter.visible = false
	else: $Shooter.visible = true
	$Shooter/PlayerHealth.value = $Shooter.health
	if $Shooter.health >= $Shooter/PlayerHealth.max_value:
		$Shooter/PlayerHealth.max_value = $Shooter.health
	$Shooter/RapidShotBar.value = rapid_upgrade
	if rapid_upgrade <= 0:
		rapid_shot = false
	$Shooter/TriShotBar.value = tri_upgrade
	if tri_upgrade <= 0:
		tri_shot = false
#	if is_hit:
#		$Shooter/PlayerHealth.visible = true
#	else: $Shooter/PlayerHealth.visible = false
	

func _on_shooter_shoot():
	if !cooldown:
		#TODO: add logic to spawn 2 aditional projectiles if tri_shot is active
		owner.add_child(_generate_pie())
		if tri_shot:
			owner.add_child(_generate_pie())
			owner.add_child(_generate_pie())
		cooldown = true
		emit_signal("start_throw")
		#TODO: send rapid_shot signal instead and implement RapidShotTimer
		if !rapid_shot:
			emit_signal("shot_fired")
		else: emit_signal("rapid_shot_fired")

func _on_shot_timer_timeout():
	_do_shoot()

func _on_shooter_hit_detected():
	if !is_hit:
		is_hit = true
		flashing = true
		emit_signal("clown_hit")
		emit_signal("flash")

func _on_hit_timer_timeout():
	is_hit = false

func _on_flash_timer_timeout():
	if is_hit:
		flashing = !flashing
		emit_signal("flash")
	else: flashing = false
	


func _on_shooter_dead():
	emit_signal("player_dead")



func _on_rapid_shot_timer_timeout():
	_do_shoot()

func _do_shoot():
	emit_signal("stop_throw")
	cooldown = false

func _on_upgrade_decrese_timer_timeout():
	rapid_upgrade = rapid_upgrade -1
	tri_upgrade = tri_upgrade -1

func _generate_pie():
	var projectile_instance = projectile.instantiate()
	projectile_instance.transform = $Shooter/AimingMarkers/Origin.global_transform
	return projectile_instance


func _on_shooter_shot_speed():
	rapid_shot = true
	rapid_upgrade = 100



func _on_shooter_tri_shot():
	tri_shot = true
	tri_upgrade = 100
