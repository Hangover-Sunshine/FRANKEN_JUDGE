extends Node2D

@export var LineWidth:float = 1 :
	set(value):
		if _lightnings == null:
			for child in get_children():
				child.set_line_width(value)
			##
		else:
			for child in _lightnings:
				child.set_line_width(value)
			##
		##
	##
##

@export var Emit:bool = false :
	get:
		return emit
	set(value):
		emit = value
		if _lightnings == null:
			for child in get_children():
				child.emitting = value
			##
		else:
			for child in _lightnings:
				child.emitting = value
			##
		##
	##
##

@export var MaxSegmentSize:float = 10 :
	set(value):
		if _lightnings == null:
			for child in get_children():
				child.MaxSegmentSize = value
			##
		else:
			for child in _lightnings:
				child.MaxSegmentSize = value
			##
		##
	##
##

@onready var _lightnings:Array = get_children()

var emit:bool = false

func set_target_position(targ_pos):
	for child in _lightnings:
		child.end_pos = targ_pos
	##
##

func set_start_position(start_pos):
	for child in _lightnings:
		child.start_pos = start_pos
	##
##
