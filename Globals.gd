extends Node


signal s_updateState


var gridRef
var advancingTick:bool = false



func advanceTick():
	if "runRulesAlgo" in gridRef:
		if not Globals.advancingTick:
			Globals.advancingTick = true
		else:
			print("globals - skipping tick advance call")
			return
		gridRef.runRulesAlgo(rulesAlgo_basic)
		s_updateState.emit()
		advancingTick = false

func randomizeGrid():
	if "runRulesAlgo" in gridRef:
		if not Globals.advancingTick:
			Globals.advancingTick = true
		else:
			print("globals - skipping randomize call")
			return
		gridRef.runRulesAlgo(rulesAlgo_randomize)
		s_updateState.emit()
		advancingTick = false


enum CellStates {DEAD=0, ALIVE=1,}





func rulesAlgo_randomize(_cell, _cellNeighbors)->CellStates:
	if randi() % 2 == 0:
		return CellStates.ALIVE
	return CellStates.DEAD

func rulesAlgo_basic(cell, cellNeighbors)->CellStates:
	#print("rules - neighbors: ", neighbors)
	var liveNeighbors = countLiveNeighbors(cellNeighbors)
	if cell.currentState == CellStates.ALIVE:
		if liveNeighbors <= 1 or liveNeighbors > 3:
			return CellStates.DEAD
		else:
			return CellStates.ALIVE
	else: # cell is dead
		if liveNeighbors == 3:
			return CellStates.ALIVE
	return CellStates.DEAD






func countLiveNeighbors(neighbors:Array)->int:
	var total = 0
	for n in neighbors:
		if "currentState" in n and n.currentState == CellStates.ALIVE:
			#print("globals - live cell")
			total += 1
	return total


#
