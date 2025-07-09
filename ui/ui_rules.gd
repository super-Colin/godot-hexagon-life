extends VBoxContainer





func _ready() -> void:
	Globals.currentExtraArgs["maxAge"] = %MaxAgeSpinBox.value
	%ToggleMaxAgeButton.toggled.connect(toggleAgeDeath)
	%MaxAgeSpinBox.value_changed.connect(updateDeathAge)
	Globals.currentExtraArgs["rainbowAgeAmount"] = %RainbowAmountSpinBox.value
	%ToggleRainbowAgingButton.toggled.connect(toggleRainbowAging)
	%RainbowAmountSpinBox.value_changed.connect(updateRainbowAmount)

func toggleAgeDeath(toggledOn):
	Globals.aging = toggledOn
	$AgingOptions.visible = toggledOn
	if toggledOn:
		Globals.currentRule = Rules.conway_age
	else:
		Globals.currentRule = Globals.defaultRule

func updateDeathAge(newVal):
	Globals.currentExtraArgs["maxAge"] = newVal


func updateRainbowAmount(newVal):
	Globals.currentExtraArgs["maxAge"] = newVal

func toggleRainbowAging(toggledOn):
	Globals.rainbowAging = toggledOn







#
