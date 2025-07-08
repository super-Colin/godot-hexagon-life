@tool
extends Node2D

var gridCellScene = preload("res://grid_cell.tscn")


@export_tool_button("Make Grid")
var makeGridAction = refreshGrid

@export var flatTopGrid:bool = false
@export var gridSize:Vector2i = Vector2i(12, 12)
@export var cellDiameter:int = 40
#@export var cellSpacing:Vector2 = Vector2(2, 2)
@export var cellSpacing:Vector2 = Vector2(0, 0)

var cellReferenceArray
var needToRefreshCellNeighbors = true



func _ready() -> void:
	if Engine.is_editor_hint():
		return
	refreshGrid()
	Globals.gridRef = $'.'

func refreshGrid():
	for c in $'.'.get_children():
		c.free()
	if $'.'.flatTopGrid:
		makeGridFlatTop()





func runRulesAlgo(rulesAlgo:Callable, extraArgs:Dictionary={}):
	#print("grid - running rules")
	for c in cellReferenceArray:
		var coord = cellReferenceArray[c].coord
		var neighbors
		#if "neighborRefs" in cellReferenceArray[c]:
		#if needToRefreshCellNeighbors or cellReferenceArray[c].neighborRefs == []:
		if needToRefreshCellNeighbors:
			cellReferenceArray[c].neighborRefs = getNeighbors(coord)
		neighbors = cellReferenceArray[c].neighborRefs 
		var stateResult = rulesAlgo.call(cellReferenceArray[c], neighbors, extraArgs)
		cellReferenceArray[c].setNextState(stateResult)
	needToRefreshCellNeighbors = false





func getNeighbors(centerCoord:Vector2i)->Array: # will not return non-existent cells, like past the edge
	#if not verifyDoubledCoord(centerCoord):
		#print("grid - get neighbors given invalid coord: ", centerCoord)
		#return []
	var neighbors = [
		neighbor_centerBottom(centerCoord),
		neighbor_rightBottom(centerCoord),
		neighbor_centerTop(centerCoord),
		neighbor_rightTop(centerCoord),
		neighbor_leftBottom(centerCoord),
		neighbor_leftTop(centerCoord),
	]
	#filter out empty entries
	neighbors = neighbors.filter(func(elem):return elem != null)
	#print("grid - returning neighbors of ", centerCoord, ":", neighbors)
	return neighbors



#It has a constraint (col + row) mod 2 == 0
func makeGridFlatTop(): # Double height coords, built column by column ("odd-q" layout) 
	cellReferenceArray = {}
	print("grid - making grid with size: ", gridSize, " and cell diameter: ", cellDiameter)
	for x in gridSize.x:
		var column = Node2D.new()
		$'.'.add_child(column)
		column.set_owner($'.')
		column.name = str(x)
		#cellReferenceArray.append([])
		for y in gridSize.y:
			var newCell = gridCellScene.instantiate()
			newCell.flatTop = true
			newCell.setSize(cellDiameter, cellDiameter/15 + 1)
			# Create position
			var x_offset = x * (cellDiameter * 0.75)
			var y_distance = sqrt(3) * (cellDiameter/2)
			var y_offset = y * y_distance
			var yCoord = y * 2 # double hieght
			var yOffset_extra = 0.0
			if x % 2 == 1: # odd rows
				yCoord += 1 # with flat top, the odd rows are pushed down (double hieght)
				yOffset_extra = y_distance / 2
			newCell.position = Vector2(x_offset, y_offset + yOffset_extra)
			column.add_child(newCell)
			newCell.set_owner($'.')
			newCell.coord = Vector2(x, yCoord)
			newCell.name = str(newCell.coord)
			#cellReferenceArray[x].append(newCell)
			cellReferenceArray[str(newCell.coord)] = newCell
	#print("grid - ref array is: ", cellReferenceArray)
	needToRefreshCellNeighbors = true


# these are all based on doubled hieght coords
func neighbor_leftTop(centerCoord:Vector2i): 
	var key = str(neighborCoord_leftTop(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_leftTop(centerCoord:Vector2i): return Vector2i(centerCoord.x-1, centerCoord.y-1)
func neighbor_centerTop(centerCoord:Vector2i):
	var key = str(neighborCoord_centerTop(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_centerTop(centerCoord:Vector2i): return Vector2i(centerCoord.x, centerCoord.y-2)
func neighbor_rightTop(centerCoord:Vector2i): 
	var key = str(neighborCoord_rightTop(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_rightTop(centerCoord:Vector2i): return Vector2i(centerCoord.x+1, centerCoord.y-1)
#
func neighbor_leftBottom(centerCoord:Vector2i):
	var key = str(neighborCoord_leftBottom(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_leftBottom(centerCoord:Vector2i): return Vector2i(centerCoord.x-1, centerCoord.y+1)
func neighbor_centerBottom(centerCoord:Vector2i):
	var key = str(neighborCoord_centerBottom(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_centerBottom(centerCoord:Vector2i): return Vector2i(centerCoord.x, centerCoord.y+2)
func neighbor_rightBottom(centerCoord:Vector2i):
	var key = str(neighborCoord_rightBottom(centerCoord))
	if key in cellReferenceArray:
		return cellReferenceArray[key]
func neighborCoord_rightBottom(centerCoord:Vector2i): return Vector2i(centerCoord.x+1, centerCoord.y+1)
#

func verifyDoubledCoord(coord:Vector2i)->bool:
	if (coord.x + coord.y) % 2 == 0:
		return true
	return false



#
