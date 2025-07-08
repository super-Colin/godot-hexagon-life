extends Node


signal s_updateState
signal s_playingToggled

# Globals references
var gridRef:Node
var advancingTick:bool = false # prevent running the process again before it finishes

# Simulation
var playing:bool = false
var timer:float = 0.0 # for targeting a certain FPS
var timerTarget:float = 0.1 # for targeting a certain FPS

var defaultRule:Callable = Rules.conway_basic
var currentRule:Callable = Rules.conway_basic
var currentExtraArgs:Dictionary = {"maxAge":8}

# Stats
var population = 0
var generation = 0

func advanceTick():
	if "runRulesAlgo" in gridRef:
		if not Globals.advancingTick:
			Globals.advancingTick = true
		else:
			print("globals - skipping tick advance call")
			return
		Globals.population = 0
		gridRef.runRulesAlgo(currentRule, currentExtraArgs)
		#gridRef.runRulesAlgo(conway_age, {"maxAge":8})
		Globals.generation +=1
		advancingTick = false
		s_updateState.emit()

func randomizeGrid():
	if "runRulesAlgo" in gridRef:
		if not Globals.advancingTick:
			Globals.advancingTick = true
		else:
			print("globals - skipping randomize call")
			return
		gridRef.runRulesAlgo(Rules.randomize_coinFlip)
		s_updateState.emit()
		advancingTick = false
		generation = 1


enum CellStates {DEAD=0, ALIVE=1,}




func togglePlaying():
	Globals.playing = ! Globals.playing
	s_playingToggled.emit()


#
#func rulesAlgo_randomize(_cell, _cellNeighbors)->CellStates:
	#if randi() % 2 == 0:
		#return CellStates.ALIVE
	#return CellStates.DEAD
#
#
#func rulesAlgo_age(cell, cellNeighbors)->CellStates:
	#if cell.age > 24:
		#cell.age = 0
		#return CellStates.DEAD
	#if rulesAlgo_basic(cell, cellNeighbors) == CellStates.DEAD:
		#cell.age = 0
		#return CellStates.DEAD
	#cell.age += 1
	#return CellStates.ALIVE
	#return rulesAlgo_basic(cell, cellNeighbors)
#
#func rulesAlgo_basic(cell, cellNeighbors)->CellStates:
	##print("rules - neighbors: ", neighbors)
	#var liveNeighbors = countLiveNeighbors(cellNeighbors)
	#if cell.currentState == CellStates.ALIVE:
		#if liveNeighbors <= 1 or liveNeighbors > 3:
			#return CellStates.DEAD
		#else:
			#return CellStates.ALIVE
	#else: # cell is dead
		#if liveNeighbors == 3:
			#return CellStates.ALIVE
	#return CellStates.DEAD
#





#func countLiveNeighbors(neighbors:Array)->int:
	#var total = 0
	#for n in neighbors:
		#if "currentState" in n and n.currentState == CellStates.ALIVE:
			##print("globals - live cell")
			#total += 1
	#return total


#
