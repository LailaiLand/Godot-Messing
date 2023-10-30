extends TileMap

var gems = 5
var collected = 0

func _on_pyramid_gem_collected():
	collected = collected + 1
	if collected >= gems:
		get_parent().get_parent().game_over()
