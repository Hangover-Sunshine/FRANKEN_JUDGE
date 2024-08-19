extends Node2D

@export var MinSegmentSize:float = 2
@export var MaxSegmentSize:float = 10
@export_range(0, 360) var AngleVar:float = 15

@onready var lightning_line:Line2D = $LightningLine

var emitting:bool = false
var start_pos:Vector2
var end_pos:Vector2
var points:Array = []

func _ready():
	$Timer.start(randf_range(0.1,0.5))
##

func _on_timer_timeout():
	if points.size() > 0:
		points.pop_front()
		lightning_line.points = points
		
		$Timer.start(0.002 + randf_range(-0.001,0.001))
	elif emitting:
		update_points()
		lightning_line.points = points
		$Timer.start(0.1 + randf_range(-0.02,0.1))
	##
##

func _process(delta):
	if emitting and $Timer.is_stopped():
		_on_timer_timeout()
	##
##

func update_points():
	var curr_line_len = 0
	points = []
	
	var start_point = start_pos
	var min_segment_size = max(start_pos.distance_to(end_pos) / 40, MinSegmentSize)
	var max_segment_size = min(start_pos.distance_to(end_pos) / 20, MaxSegmentSize)
	
	while curr_line_len < Vector2().distance_to(end_pos):
		var move_vec = start_point.direction_to(end_pos) * randf_range(min_segment_size, max_segment_size)
		var new_point = start_point + move_vec
		var nprot = start_point + move_vec.rotated(deg_to_rad(randf_range(-AngleVar, AngleVar)))
		points.append(nprot)
		start_point = new_point
		curr_line_len = start_point.length()
	##
	
	points.append(end_pos)
##

func set_line_width(width:float):
	lightning_line.width = width
##
