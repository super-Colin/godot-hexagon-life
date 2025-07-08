extends VBoxContainer








func _ready() -> void:
	Globals.s_updateState.connect(updateStatsLabels)



func updateStatsLabels():
	%Population.text = "Population: " + str(Globals.population)
	%Generation.text = "Generation: " + str(Globals.generation)
