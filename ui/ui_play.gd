extends VBoxContainer






func _ready() -> void:
	%RandomizeButton.pressed.connect(Globals.randomizeGrid)
	%AdvanceTickButton.pressed.connect(Globals.advanceTick)
	%PlayButton.pressed.connect(Globals.togglePlaying)
	%SpeedHSlider.drag_ended.connect(fpsDragEnded)
	Globals.s_playingToggled.connect(playingToggled)


func _process(delta: float) -> void:
	%ActualSpeedLabel.text = "FPS: " + str(1.0 / delta).pad_decimals(2)


func playingToggled():
	if Globals.playing:
		%PlayButton.text = "Pause"
	else:
		%PlayButton.text = "Play"



func fpsDragEnded(valChanged):
	if not valChanged:
		return
	updateTimer()


func updateTimer():
	Globals.timerTarget = %SpeedHSlider.value / 60.0
	print("ui_play - new timerTarget is: ", Globals.timerTarget)
	#%SpeedLabel.text = str(%SpeedHSlider.value) + "ticks/s"
	%SpeedLabel.text = str(1.0 / Globals.timerTarget).pad_decimals(2) + "ticks/s"




#
