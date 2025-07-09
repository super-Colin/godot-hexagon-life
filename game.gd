extends Control






func _ready() -> void:
	Globals.randomizeGrid()



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ZoomIn"):
		#print("zoom in")
		set_zoom(%Camera2D.zoom * 1.1)
	elif Input.is_action_just_pressed("ZoomOut"):
		#print("zoom out")
		set_zoom(%Camera2D.zoom * 0.9)
	if Input.is_action_just_pressed("TogglePlaying"):
		Globals.togglePlaying()
	if Input.is_action_just_pressed("Randomize"):
		Globals.randomizeGrid()
	elif Globals.playing:
		Globals.timer += delta
		if Globals.timer >= Globals.timerTarget:
			#print("game - timer is: ", timer, ", delta is: ", delta)
			Globals.advanceTick()
			Globals.timer = 0.0
	#%ActualSpeedLabel.text = "FPS: " + str(1.0 / delta).pad_decimals(2)










#func set_zoom(delta: Vector2):
func set_zoom(newZoom):
	var mouse_pos := get_global_mouse_position()
	#$Camera2D.zoom += delta
	%Camera2D.zoom = newZoom
	var new_mouse_pos := get_global_mouse_position()
	%Camera2D.position += mouse_pos - new_mouse_pos



















#
