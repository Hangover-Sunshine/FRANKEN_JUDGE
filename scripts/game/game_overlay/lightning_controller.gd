extends Node2D

@onready var clergy_bolts = [
	$ClergyBolt, $ClergyBolt2, $ClergyBolt3, $ClergyBolt4
]
@onready var nobility_bolts = [
	$NobilityBolt, $NobilityBolt2, $NobilityBolt3, $NobilityBolt4
]
@onready var peasant_bolts = [
	$PeasantBolt, $PeasantBolt2, $PeasantBolt3, $PeasantBolt4
]

const _START_POSITION:Vector2 = Vector2(1130, 710)

# Peasants: 0 - 4, Nobles: 10 - 14, Clergy: 20 - 24
# Also, this: 
var positions:Dictionary = {}

func _ready():
	var offset = 0
	
	var markers = $"../Markers"
	var count = 0
	for child in markers.get_children():
		positions[offset * 10 + count] = child.global_position
		count += 1
		
		if count == 5:
			count = 0
			offset += 1
		##
	##
	
	print(positions)
	
	# Get rid of them, don't keep them in the cache/memory -- it's a waste now
	markers.queue_free()
	
	# Set all starts right now -- this never changes
	for bolt in clergy_bolts:
		bolt.set_start_position(_START_POSITION)
	##
	for bolt in peasant_bolts:
		bolt.set_start_position(_START_POSITION)
	##
	for bolt in nobility_bolts:
		bolt.set_start_position(_START_POSITION)
	##
##

var emit_clergy:bool = false
var emit_nobility:bool = false
var emit_peasant:bool = false
var open_bolt:int = 0
var zapping

func setup(faction:GlobalData.Faction, effects:Array[BaseEffectResource]):
	zapping = SoundManager.instance("env", "zapping")
	var bolts = []
	
	if faction == GlobalData.Faction.PEASANTS:
		bolts = peasant_bolts
		emit_peasant = true
	elif faction == GlobalData.Faction.NOBILITY:
		bolts = nobility_bolts
		emit_nobility = true
	else:
		bolts = clergy_bolts
		emit_clergy = true
	##
	
	for eff in effects:
		bolts[open_bolt].set_target_position(positions[10 * eff.Group + eff.Affect - 1])
		open_bolt += 1
	##
##

func emit_bolts():
	var bolts
	
	if emit_peasant:
		bolts = peasant_bolts
	##
	if emit_clergy:
		bolts = clergy_bolts
	##
	if emit_nobility:
		bolts = nobility_bolts
	##
	
	for i in range(open_bolt):
		bolts[i].Emit = true
	##
	
	zapping.trigger()
##

func disable_bolts():
	var bolts
	
	if emit_peasant:
		bolts = peasant_bolts
	##
	if emit_clergy:
		bolts = clergy_bolts
	##
	if emit_nobility:
		bolts = nobility_bolts
	##
	
	for i in range(open_bolt):
		bolts[i].Emit = false
	##
	
	emit_clergy = false
	emit_nobility = false
	emit_peasant = false
	open_bolt = 0
	zapping.release()
##
