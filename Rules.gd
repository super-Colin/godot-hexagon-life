extends Node




func randomize_coinFlip(_cell, _cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	if randi() % 2 == 0:
		return Globals.CellStates.ALIVE
	return Globals.CellStates.DEAD


func conway_age(cell, cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	var maxAge = 24
	if "maxAge" in extraArgs:
		maxAge = extraArgs.maxAge
	if cell.age > maxAge:
		cell.age = 0
		return Globals.CellStates.DEAD
	if conway_basic(cell, cellNeighbors, extraArgs) == Globals.CellStates.DEAD:
		cell.age = 0
		return Globals.CellStates.DEAD
	cell.age += 1
	return Globals.CellStates.ALIVE

func conway_basic(cell, cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	#print("rules - neighbors: ", neighbors)
	var liveNeighbors = countLiveNeighbors(cellNeighbors)
	if cell.currentState == Globals.CellStates.ALIVE:
		if liveNeighbors <= 1 or liveNeighbors > 3:
			return Globals.CellStates.DEAD
		else:
			return Globals.CellStates.ALIVE
	else: # cell is dead
		if liveNeighbors == 3:
			return Globals.CellStates.ALIVE
	return Globals.CellStates.DEAD






func countLiveNeighbors(neighbors:Array)->int:
	var total = 0
	for n in neighbors:
		if "currentState" in n and n.currentState == Globals.CellStates.ALIVE:
			#print("globals - live cell")
			total += 1
	return total




#
