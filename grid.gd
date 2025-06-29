@tool
extends Node2D

@export_tool_button("Make Grid")
var makeGridAction = refreshGrid

@export var flatTopGrid:bool = false
@export var gridSize:Vector2i = Vector2i(12, 12)
@export var cellDiameter:int = 40
#@export var cellSpacing:Vector2 = Vector2(2, 2)
@export var cellSpacing:Vector2 = Vector2(0, 0)

var gridCellScene = preload("res://grid_cell.tscn")


func refreshGrid():
	for c in $'.'.get_children():
		c.free()
	if $'.'.flatTopGrid:
		makeGridFlatTop()



func makeGridFlatTop(): # Double height coords
	for x in gridSize.x:
		var column = Node2D.new()
		$'.'.add_child(column)
		column.set_owner($'.')
		column.name = str(x)
		for y in gridSize.y:
			var newCell = gridCellScene.instantiate()
			newCell.flatTop = true
			newCell.setSize(cellDiameter)
			# Create position
			var x_offset = x * (cellDiameter * 0.75)
			var y_distance = sqrt(3) * (cellDiameter/2)
			var y_offset = y * y_distance
			var yCoord = y * 2 # double hieght
			var yOffset_extra = 0.0
			if x % 2 == 1: # odd rows
				yCoord += 1 # with flat top, the odd rows are pushed down (double hieght)
				yOffset_extra = y_distance / 2
			#newCell.position = Vector2(x_offset, y_offset)
			newCell.position = Vector2(x_offset, y_offset + yOffset_extra)
			column.add_child(newCell)
			newCell.set_owner($'.')
			newCell.name = str(yCoord)
# FLAT TOP:
#the horizontal distance between adjacent hexagons centers is horiz = 3/4 * width = 3/2 * size. 
#The vertical distance is vert = height = sqrt(3) * size = 2 * inradius


func cartesianToDoubled(coords:Vector2, flatTop:bool=false)->Vector2: # flat top = double hieight
	
	return Vector2()



#func makeGrid():
	#for y in gridSize.y:
		#var row = Node2D.new()
		#add_child(row)
		#row.set_owner(self)
		#row.name = str(y)
		#for x in gridSize.x:
			#var newCell = gridCellScene.instantiate()
#
			#var xOffset_extra = 0.0
			#if int(y) % 2 == 1:
				#xOffset_extra = cellDiameter * 0.5
#
			## Correct spacing
			#var x_offset = x * (cellDiameter * 0.75) + xOffset_extra + (cellSpacing.x * x)
			#var y_offset = y * cellDiameter + (cellSpacing.y * y)
#
			#newCell.position = Vector2(x_offset, y_offset)
			#newCell.setSize(cellDiameter)
			#row.add_child(newCell)
			#newCell.set_owner(self)




#func makeGrid(flatTop:bool=false):
	#for x in gridSize.x:
		#var column = Node2D.new()
		#$'.'.add_child(column)
		#column.set_owner($'.')
		#column.name = str(x)
		#for y in gridSize.y:
			#var newCell = gridCellScene.instantiate()
			#newCell.flatTop = flatTop
			#newCell.create_hexagon_polygon(cellDiameter)
			#var xOffset_extra = 0.0
			#if int(y) % 2 == 1:
				#xOffset_extra = cellDiameter / 1.4
			#var xOffset = x * (cellDiameter * 1.4) + xOffset_extra + (cellSpacing.x * x)
			#var yOffset = y * (cellDiameter / 2.6) + (cellSpacing.y * y)
			 ##horiz = 3/4 * width = 3/2 * size. 
			##The vertical distance is vert = height = sqrt(3) * size = 2 * inradius.
			#
			#newCell.position = Vector2(xOffset, yOffset)
			#newCell.setSize(cellDiameter)
			#column.add_child(newCell)
			#newCell.set_owner($'.')
			#newCell.name = str(x)+", "+str(y)




#
