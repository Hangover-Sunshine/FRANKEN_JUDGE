extends Node

## Starting reptuation for the clergy.
@export var StartingClergyRep:int = 50

## Starting reputation for the nobility.
@export var StartingNobilityRep:int = 50

## Starting reputation for the peasants.
@export var StartingPeasantRep:int = 50

## The three reputations of the game.
var _reputations:Dictionary = {
	GlobalData.Faction.CLERGY: 50,
	GlobalData.Faction.NOBILITY: 50,
	GlobalData.Faction.PEASANTS: 50
}

func _ready():
	_reputations[GlobalData.Faction.CLERGY] = StartingClergyRep
	_reputations[GlobalData.Faction.NOBILITY] = StartingNobilityRep
	_reputations[GlobalData.Faction.PEASANTS] = StartingPeasantRep
##

func has_lost() -> GlobalData.END_CONDITION:
	var lowest_faction:GlobalData.Faction = GlobalData.Faction.PEASANTS
	var zero_hit:bool = false
	
	for key in _reputations.keys():
		# Grab the first lowest
		if _reputations[key] == 0:
			zero_hit = true
			lowest_faction = key
			break
		##
	##
	
	if zero_hit:
		match lowest_faction:
			GlobalData.Faction.CLERGY:
				return GlobalData.END_CONDITION.LOSS_CLERGY
			GlobalData.Faction.NOBILITY:
				return GlobalData.END_CONDITION.LOSS_NOBILITY
			GlobalData.Faction.PEASANTS:
				return GlobalData.END_CONDITION.LOSS_PEASANT
			##
		##
	##
	
	return GlobalData.END_CONDITION.NONE
##

func set_reputation_for(group:GlobalData.Faction, value:int):
	_reputations[group] += value
	_reputations[group] = min(100, max(0, _reputations[group]))
##

func get_reputations():
	return _reputations
##

func get_reputation_for(group:GlobalData.Faction) -> int:
	return _reputations[group]
##
