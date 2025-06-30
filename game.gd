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
	if playing:
		timer += delta
		if timer >= timerTarget:
			timer = 0.0
			Globals.advanceTick()

func fpsDragEnded(valChanged):
	if not valChanged:
		return
	updateTimer()

func updateTimer():
	timerTarget = %SpeedHSlider.value / 60.0
	print("game - new timerTarget is: ", timerTarget)
	%SpeedLabel.text = str(%SpeedHSlider.value) + "ticks/s"
