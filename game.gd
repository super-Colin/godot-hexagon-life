extends Control


var playing = false
var timer = 0.0
var timerTarget = 0.1





func _ready() -> void:
	%RandomizeButton.pressed.connect(Globals.randomizeGrid)
	%AdvanceTickButton.pressed.connect(Globals.advanceTick)
	%PlayButton.pressed.connect(togglePlaying)
	%SpeedHSlider.drag_ended.connect(fpsDragEnded)


func togglePlaying():
	playing = ! playing
	if playing:
		%PlayButton.text = "Pause"
	else:
		%PlayButton.text = "Play"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ZoomIn"):
		print("zoom in")
		set_zoom(%Camera2D.zoom * 1.1)
		#%Camera2D.zoom *= 1.1
	elif Input.is_action_just_pressed("ZoomOut"):
		print("zoom out")
		set_zoom(%Camera2D.zoom * 0.9)
		#%Camera2D.zoom * 0.9
	if Input.is_action_just_pressed("TogglePlaying"):
		togglePlaying()
	if Input.is_action_just_pressed("Randomize"):
		Globals.randomizeGrid()
	elif playing:
		timer += delta
		if timer >= timerTarget:
			#print("game - timer is: ", timer, ", delta is: ", delta)
			Globals.advanceTick()
			timer = 0.0
	%ActualSpeedLabel.text = "FPS: " + str(1.0 / delta).pad_decimals(2)

func fpsDragEnded(valChanged):
	if not valChanged:
		return
	updateTimer()

func updateTimer():
	timerTarget = %SpeedHSlider.value / 60.0 # 60 / 60 = 1 || 1 / 60 = 0.016
	print("game - new timerTarget is: ", timerTarget)
	#%SpeedLabel.text = str(%SpeedHSlider.value) + "ticks/s"
	%SpeedLabel.text = str(1.0 / timerTarget).pad_decimals(2) + "ticks/s" # 60 ? ?? = 1 || 1 ? ? = 60








#func set_zoom(delta: Vector2):
func set_zoom(newZoom):
	var mouse_pos := get_global_mouse_position()
	#$Camera2D.zoom += delta
	%Camera2D.zoom = newZoom
	var new_mouse_pos := get_global_mouse_position()
	%Camera2D.position += mouse_pos - new_mouse_pos



















#
