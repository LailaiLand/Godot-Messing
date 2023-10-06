extends Timer

func _ready():
	one_shot = true

func _on_player_rapid_shot_fired():
	start()

