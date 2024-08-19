class_name Card
extends Panel

signal selected
signal pressed_down
signal released

@onready var button = $Button

func enable():
	button.mouse_filter = MOUSE_FILTER_STOP
##

func disable():
	button.mouse_filter = MOUSE_FILTER_IGNORE
##
