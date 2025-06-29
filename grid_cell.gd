@tool
extends Area2D

@export_tool_button("make Hexagon")
var makeHexagonAction = setSize

@export var borderWidth:int = 2
@export var flatTop:bool = false


var defaultDiameter = 40



func setSize(newSizeDiameter:int = defaultDiameter):
	var borderedHexagon = create_hexagon_polygon(newSizeDiameter - borderWidth*2)
	var fullSizeHexagon = create_hexagon_polygon(newSizeDiameter)
	$Clickbox.polygon = borderedHexagon
	$BorderColorPolygon.polygon = fullSizeHexagon
	$BgColorPolygon.polygon = borderedHexagon



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






#
