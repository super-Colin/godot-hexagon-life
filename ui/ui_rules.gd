extends VBoxContainer






func _ready() -> void:
	%MaxAgeSpinBox.value_changed.connect(updateDeathAge)
	%ToggleMaxAgeButton.toggled.connect(toggleAgeDeath)

func toggleAgeDeath(toggledOn):
	if toggledOn:
		Globals.currentRule = Rules.conway_age
	else:
		Globals.currentRule = Globals.defaultRule

func updateDeathAge(newVal):
	#Globals.currentExtraArgs["maxAge"] = %MaxAgeSpinBox.value
	Globals.currentExtraArgs["maxAge"] = newVal
