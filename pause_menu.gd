extends CanvasLayer
var rotation_speed = 0.06
var shooter_head
var selection = ["start", "previous", "next", "close"]
var select_index = 0
var select_range = 3
var map_index
var map_length
var main_scene

signal select_pressed

func _ready():
	shooter_head = get_node("ShooterHead")
	#main_scene = get_parent()
	#map_length = main_scene.maps.size()
	map_index = 0

func _process(_delta):
	_floating_animation()
	_handle_selection()

func _floating_animation():
	shooter_head.rotation += rotation_speed

func _handle_selection():
	_select_position()
	_select_controls()

func _select_position():
	if selection[select_index] == "start":
		shooter_head.position = $StartMarker.position
	elif selection[select_index] == "previous":
		shooter_head.position = $PreviousMarker.position
	elif selection[select_index] == "next":
		shooter_head.position = $NextMarker.position
	elif selection[select_index] == "close":
		shooter_head.position = $CloseMarker.position

func _select_controls():
	if Input.is_action_just_pressed("downBiter") or Input.is_action_just_pressed("rightBiter"):
		select_index = select_index +1
		emit_signal("select_pressed")
		if select_index > select_range:
			select_index = 0
	if Input.is_action_just_pressed("upBiter") or Input.is_action_just_pressed("leftBiter"):
		select_index = select_index -1
		if select_index < 0:
			select_index = select_range


func _on_start_button_mouse_entered():
	select_index = 0


func _on_previous_button_mouse_entered():
	select_index = 1


func _on_next_button_mouse_entered():
	select_index = 2


func _on_close_button_mouse_entered():
	select_index = 3
