extends VBoxContainer








func _ready() -> void:
	%RemakeButton.pressed.connect(remakeGridWithNewSize)



func remakeGridWithNewSize():
	if "refreshGrid" in Globals.gridRef:
		Globals.gridRef.gridSize = Vector2(%XSpinBox.value, %YSpinBox.value)
		Globals.gridRef.refreshGrid()

















#
