extends Node2D

signal confirm_case(effects:Array[BaseEffectResource])

## The number of turns the game should last.
@export var NUMBER_OF_TURNS:int = 25

## All cases in the game.
@export var CASES:Array[BaseCaseResource]

## Current day.
var _curr_day:int = 1

@onready var _faction_stats = $FactionStats
@onready var _reptuation_stats = $ReptuationStats

## Called when node is in the tree.
func _ready():
	connect("confirm_case", _confirm_case)
##

## Fired when the case has been submit.
func _confirm_case(effects:Array[BaseEffectResource]):
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
		_reptuation_stats.set_reputation_for(key, changes[key])
	##
	
	# TODO: Save the current day -- let player back out without worry
	
	# TODO: Send off for animations :)
##
