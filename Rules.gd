extends Node



var stripeCounter = 0
func randomize_stripes(_cell, _cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	var stripeLength = 6
	if "maxstripeLength" in extraArgs:
		stripeLength = extraArgs.stripeLength
	var gapLength = 6
	if "maxstripeLength" in extraArgs:
		stripeLength = extraArgs.stripeLength
	if stripeCounter < stripeLength:
		stripeCounter += 1
		Globals.population +=1
		return Globals.CellStates.ALIVE
	return Globals.CellStates.DEAD

func randomize_coinFlip(_cell, _cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	if randi() % 2 == 0:
		Globals.population +=1
		return Globals.CellStates.ALIVE
	return Globals.CellStates.DEAD


func conway_age(cell, cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	var maxAge = 24
	if "maxAge" in extraArgs:
		maxAge = extraArgs.maxAge
	if cell.age > maxAge:
		return Globals.CellStates.DEAD
	if conway_basic(cell, cellNeighbors, extraArgs) == Globals.CellStates.DEAD:
		return Globals.CellStates.DEAD
	cell.age += 1
	Globals.population +=1 # reset to 0 each cycle
	return Globals.CellStates.ALIVE

func conway_basic(cell, cellNeighbors, extraArgs:Dictionary={})->Globals.CellStates:
	#print("rules - neighbors: ", neighbors)
	var liveNeighbors = countLiveNeighbors(cellNeighbors)
	if cell.currentState == Globals.CellStates.ALIVE:
		if liveNeighbors <= 1 or liveNeighbors > 3:
			return Globals.CellStates.DEAD
		else:
			Globals.population +=1
			return Globals.CellStates.ALIVE
	else: # cell is dead
		if liveNeighbors == 3:
			Globals.population +=1
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
