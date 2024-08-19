extends Node2D

@onready var peasant_bolt = $PeasantBolt
@onready var nobility_bolt = $NobilityBolt
@onready var clergy_bolt = $ClergyBolt

func _ready():
	peasant_bolt.set_start_position(Vector2(100, 100))
	peasant_bolt.set_target_position(Vector2(900, 100))
	
	nobility_bolt.set_start_position(Vector2(100, 400))
	nobility_bolt.set_target_position(Vector2(900, 400))
	
	clergy_bolt.set_start_position(Vector2(100, 700))
	clergy_bolt.set_target_position(Vector2(900, 700))
	
	peasant_bolt.Emit = true
	clergy_bolt.Emit = true
	nobility_bolt.Emit = true
##
