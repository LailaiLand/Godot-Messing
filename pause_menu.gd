extends CanvasLayer
var rotation_speed = 0.06
var shooter_head
var selection = ["start", "previous", "next", "close"]
var select_index = 0
var select_range = 3
var map_index
var map_range
var main_scene
var is_paused

signal select_new_game
signal select_close

func ready_hook():
	shooter_head = get_node("ShooterHead")
	main_scene = get_parent()
	map_range = main_scene.maps.size() - 1
	map_index = 0

func _process(_delta):
	$LevelLabel.text = str(map_index + 1)
	_floating_animation()
	_handle_selection()
	if is_paused:
		if Input.is_action_just_pressed("confirm"):
			_confirm_pressed(selection[select_index])
		if Input.is_action_just_pressed("pause"):
			emit_signal("select_close")
			is_paused = false
	else:
		is_paused = true

func _floating_animation():
	shooter_head.rotation += rotation_speed

func _handle_selection():
	_select_position()
	_select_move()

func _select_position():
	if selection[select_index] == "start":
		shooter_head.position = $StartMarker.position

	elif selection[select_index] == "previous":
		shooter_head.position = $PreviousMarker.position

	elif selection[select_index] == "next":
		shooter_head.position = $NextMarker.position

	elif selection[select_index] == "close":
		shooter_head.position = $CloseMarker.position


func _select_move():
	if Input.is_action_just_pressed("downBiter") or Input.is_action_just_pressed("rightBiter"):
		select_index = select_index +1
		if select_index > select_range:
			select_index = 0
	if Input.is_action_just_pressed("upBiter") or Input.is_action_just_pressed("leftBiter"):
		select_index = select_index -1
		if select_index < 0:
			select_index = select_range

func _level_select(direction):
	if direction == "previous":
		map_index = map_index - 1
		if map_index < 0:
			map_index = map_range
	if direction == "next":
		map_index = map_index + 1
		if map_index > map_range:
			map_index = 0

func _confirm_pressed(position):
	if position == "start":
		emit_signal("select_new_game", map_index)
		is_paused = false
	if position == "previous":
		_level_select(position)
	if position == "next":
		_level_select(position)
	if position == "close":
		emit_signal("select_close")
		is_paused = false

func _on_start_button_mouse_entered():
	select_index = 0


func _on_previous_button_mouse_entered():
	select_index = 1


func _on_next_button_mouse_entered():
	select_index = 2


func _on_close_button_mouse_entered():
	select_index = 3


func _on_start_button_button_up():
	emit_signal("select_new_game", map_index)
	is_paused = false

func _on_close_button_button_up():
	emit_signal("select_close")
	is_paused = false


func _on_previous_button_button_up():
	_level_select("previous")


func _on_next_button_button_up():
	_level_select("next")
