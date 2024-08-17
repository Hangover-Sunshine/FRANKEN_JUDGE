extends Node2D

signal confirm_case(effects:Array[BaseEffectResource])
signal update_stats_done

## The number of turns the game should last.
@export var NUMBER_OF_TURNS:int = 25

## All cases in the game.
@export var CASES:Array[BaseCaseResource]

## Current day.
var _curr_day:int = 1

@onready var _faction_stats = $FactionStats
@onready var _reputation_stats = $RepuationStats

## Called when node is in the tree.
func _ready():
	Verho.connect("loaded_scene", _loaded_scene)
	connect("confirm_case", _confirm_case)
	connect("update_stats_done", _update_stats_done)
##

## Fired when the case has been submit.
func _confirm_case(effects:Array[BaseEffectResource]):
	_curr_day += 1
	
	# Update stats
	for eff in effects:
		# group:GlobalData.Faction, stat:GlobalData.Effects, value:in
		if eff.RandomAmount:
			_faction_stats.update_value_for(eff.Group, eff.Affect,
											randi_range(eff.ValueRange.x, eff.ValueRange.y))
		else:
			_faction_stats.update_value_for(eff.Group, eff.Affect, eff.ValueChange)
		##
	##
	
	# Get the amount changes to reputations
	var changes:Dictionary = {
		GlobalData.Faction.CLERGY: 0,
		GlobalData.Faction.NOBILITY: 0,
		GlobalData.Faction.PEASANTS: 0
	}
	
	# ... And Change the reputations - all in one!
	for key in changes.keys():
		changes[key] = _faction_stats.get_faction_rep_change(key)
		_reputation_stats.set_reputation_for(key, changes[key])
	##
	
	# TODO: Save the current day -- let player back out without worry
	
	# TODO: Send off for animations :)
##

## Called once the animation player is finished playing all the animations --
##	and confirmed by the player.
func _update_stats_done():
	# Did we lose? Did we win?
	var status:GlobalData.END_CONDITION = _reputation_stats.has_lost()
	
	if _curr_day == NUMBER_OF_TURNS:
		if status == GlobalData.END_CONDITION.LOSS_ALL:
			pass # You just lose
		elif status == GlobalData.END_CONDITION.LOSS_CLERGY or \
				status == GlobalData.END_CONDITION.LOSS_NOBILITY or \
				status == GlobalData.END_CONDITION.LOSS_PEASANT:
				pass # Win, but barely
			##
		##
		
		pass # Win
	elif status != GlobalData.END_CONDITION.NONE:
		pass # Just lost, that's it
	##
##

func _loaded_scene(scene_name):
	if scene_name != name:
		queue_free()
	##
##
