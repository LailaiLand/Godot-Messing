extends TileMap

var gems = 5
var collected = 0
var main_scene

signal victory

func _ready():
	main_scene = get_parent().get_parent()
	connect("victory", main_scene._on_castle_victory)

func _on_pyramid_gem_collected():
	collected = collected + 1
	if collected >= gems:
		emit_signal("victory")
