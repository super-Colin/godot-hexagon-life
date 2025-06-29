@tool
extends Area2D

@export_tool_button("make Hexagon")
var makeHexagonAction = setSize

@export var defaultBorderWidth:int = 10
@export var defaultDiameter:int = 100
@export var flatTop:bool = false

@export var defaultBorderColor:Color = Color.WEB_GRAY
@export var defaultBgColor:Color = Color.WHITE
@export var selectedBorderColor:Color = Color.BLACK
@export var selectedBgColor:Color = Color.ORANGE

var hoveringOn = false

func _ready() -> void:
	$'.'.mouse_entered.connect($'.'.mouseEntered)
	$'.'.mouse_exited.connect($'.'.mouseExited)
	$'.'.changeBorderColor(defaultBorderColor)
	$'.'.changeBgColor(defaultBgColor)

func setSize(newSizeDiameter:int = defaultDiameter):
	var borderedHexagon = create_hexagon_polygon(newSizeDiameter - defaultBorderWidth*2)
	var fullSizeHexagon = create_hexagon_polygon(newSizeDiameter)
	$Clickbox.polygon = borderedHexagon
	$BorderColorPolygon.polygon = fullSizeHexagon
	$BgColorPolygon.polygon = borderedHexagon

func mouseEntered():
	hoveringOn = true
	$'.'.changeBorderColor(selectedBorderColor)
	$'.'.changeBgColor(selectedBgColor)
	$'.'.changeBorderWidth( (defaultBorderWidth * 1.3) + 5)

func mouseExited():
	hoveringOn = false
	$'.'.changeBorderColor(defaultBorderColor)
	$'.'.changeBgColor(defaultBgColor)
	$'.'.changeBorderWidth(defaultBorderWidth)

func create_hexagon_polygon(diameter: float):
	var points: PackedVector2Array = []
	for i in range(6):
		var angle = deg_to_rad(60 * i)
		if not flatTop:
			angle = deg_to_rad(60 * i - 30) # offset so flat sides are veritcal
		var x = (diameter/2) * cos(angle)
		var y = (diameter/2) * sin(angle)
		points.append(Vector2(x, y))
	return points

#func _mouse_enter() -> void:
	#


func changeBorderColor(newColor:Color = Color.BLACK):
	$BorderColorPolygon.color = newColor
func changeBgColor(newColor:Color = Color.CHOCOLATE):
	$BgColorPolygon.color = newColor
func changeBorderWidth(newWidth:int):
	$BgColorPolygon.polygon = create_hexagon_polygon(defaultDiameter - newWidth*2)




#
