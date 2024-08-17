extends Node

## Starting reptuation for the clergy.
@export var StartingClergyRep:float = 50

## Starting reputation for the nobility.
@export var StartingNobilityRep:float = 50

## Starting reputation for the peasants.
@export var StartingPeasantRep:float = 50

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

func set_reputation_for(group:GlobalData.Faction, value:float):
	pass
##

func get_reputation_for(group:GlobalData.Faction) -> float:
	return _reputations[group]
##
