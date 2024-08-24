class_name Card
extends Panel

signal selected(faction:GlobalData.Faction, effects:Array[BaseEffectResource])
signal pressed_down
signal released

@onready var button = $Button

func enable():
	button.visible = true
	button.mouse_filter = MOUSE_FILTER_STOP
##

func disable():
	button.visible = false
	button.mouse_filter = MOUSE_FILTER_IGNORE
##
