@tool
extends Area2D




@export_tool_button("make Hexagon")
var makeHexagonAction = setSize

@export var defaultBorderWidth:int = 10
@export var defaultDiameter:int = 100
@export var flatTop:bool = false

@export var defaultBorderColor:Color = Color.WEB_GRAY
@export var defaultBgColor:Color = Color.WHITE
@export var defaultSelectedBorderColor:Color = Color.BLACK
@export var defaultSelectedBgColor:Color = Color.ORANGE

var currentBorderColor:Color = defaultBorderColor
var currentBgColor:Color = defaultBgColor
var selectedBorderColor:Color = defaultSelectedBorderColor
var selectedBgColor:Color = defaultSelectedBgColor
var hoveringOn:bool = false
var toggledOn:bool = false
var age:int = 0:
	set(newVal):
		age = newVal
		toCurrentColor()
var neighborRefs:Array = []


# State vars
var coord:Vector2i
var currentState:Globals.CellStates=Globals.CellStates.DEAD:
	set(newVal):
		if currentState == newVal: return
		if currentState == Globals.CellStates.DEAD: age = 0
		currentState = newVal
		setColorWithState()
var nextState:Globals.CellStates=Globals.CellStates.DEAD
var knowledge:Dictionary = {}
var traits:Dictionary = {}


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	$'.'.mouse_entered.connect($'.'.mouseEntered)
	$'.'.mouse_exited.connect($'.'.mouseExited)
	$'.'.changeBorderColor(defaultBorderColor)
	$'.'.changeBgColor(defaultBgColor)
	Globals.s_updateState.connect(func():currentState = nextState)

func setSize(newSizeDiameter:int = defaultDiameter, newBorderWidth = defaultBorderWidth):
	defaultDiameter = newSizeDiameter
	defaultBorderWidth = newBorderWidth
	var borderedHexagon = create_hexagon_polygon(newSizeDiameter - defaultBorderWidth*2)
	var fullSizeHexagon = create_hexagon_polygon(newSizeDiameter)
	$Clickbox.polygon = fullSizeHexagon
	$BorderColorPolygon.polygon = fullSizeHexagon
	$BgColorPolygon.polygon = borderedHexagon

func setNextState(newState:Globals.CellStates):
	#currentState = newState
	nextState = newState
	#setColorWithState()

func setColorWithState():
	if currentState == Globals.CellStates.ALIVE: 
		currentBgColor = Color.DARK_MAGENTA
		selectedBgColor = Color.LIGHT_SALMON
	else:
		currentBgColor = defaultBgColor
		selectedBgColor = defaultSelectedBgColor
	toCurrentColor()




func mouseEntered():
	hoveringOn = true
	if Input.is_action_pressed("MainClick"):
		clickedOn_main()
	#toSelectedColor()

func mouseExited():
	hoveringOn = false
	#toCurrentColor()

func toSelectedColor():
	$'.'.changeBorderColor(selectedBorderColor)
	$'.'.changeBgColor(selectedBgColor)
	#$'.'.changeBorderWidth( (defaultBorderWidth * 1.3) + 5)

func toCurrentColor():
	if Globals.aging:
		$'.'.changeBgColor(interpolateColorWithAge())
	else:
		$'.'.changeBgColor(currentBgColor)
	$'.'.changeBorderColor(currentBorderColor)
	#$'.'.changeBorderWidth(defaultBorderWidth)


func interpolateColorWithAge():
	var lerpWeight
	if Globals.rainbowAging: # Already know we are using age in this function
		var newColor = currentBgColor
		#newColor.h += currentBgColor.h * age
		newColor.h += (Globals.currentExtraArgs["rainbowAgeAmount"]/100) * age
		return newColor
	else:
		lerpWeight = (1.0 / Globals.currentExtraArgs["maxAge"]) * float(age)
	#print("cell - lerpWeight is: ", lerpWeight, ", age is: ", age, ", max age is: ", Globals.currentExtraArgs["maxAge"], ", ", (1.0 / Globals.currentExtraArgs["maxAge"]))
	return currentBgColor.lerp(defaultBgColor, lerpWeight)




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



func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("MainClick"):
	#if Input.is_action_pressed("MainClick"):
	#if Input.is_action_just_pressed("MainClick"):
	#if Input.is_action_just_released("MainClick"):
		if hoveringOn:
			clickedOn_main()
			#print("cell - clicked")
		
#func _mouse_enter() -> void:
	#


func changeBorderColor(newColor:Color = Color.BLACK):
	$BorderColorPolygon.color = newColor
func changeBgColor(newColor:Color = Color.CHOCOLATE):
	$BgColorPolygon.color = newColor
func changeBorderWidth(newWidth:int):
	$BgColorPolygon.polygon = create_hexagon_polygon(defaultDiameter - newWidth*2)



func clickedOn_main():
	#toggledOn = ! toggledOn
	if currentState == Globals.CellStates.ALIVE:
		currentState = Globals.CellStates.DEAD
	else:
		currentState = Globals.CellStates.ALIVE
	setColorWithState()
	toCurrentColor()
#
