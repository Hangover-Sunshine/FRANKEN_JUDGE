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
	var below_25:int = 0
	var below_35:int = 0
	
	for key in _reputations.keys():
		if _reputations[key] < 25:
			below_25 += 1
			below_35 += 1
			if _reputations[key] < _reputations[lowest_faction]:
				lowest_faction = key
			##
		##
		if _reputations[key] < 35:
			below_35 += 1
		##
	##
	
	# Early check -- if all are 3, you really failed
	if below_25 == 3:
		return GlobalData.END_CONDITION.LOSS_ALL
	##
	
	if below_25 > 0 and below_35 > 1:
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
