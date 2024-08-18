extends Node2D

signal case_complete(case:BaseCaseResource, faction:GlobalData.Faction, chose_left:bool)

@export var HoldDuration:float = 3

@onready var peasant_cards = [
	$Scale_Body/Scale_Left/Left_Peasant_Card,
	$Scale_Body/Scale_Right/Right_Peasant_Card
]
@onready var nobility_cards = [
	$Scale_Body/Scale_Left/Left_Nobility_Card,
	$Scale_Body/Scale_Right/Right_Nobility_Card
]
@onready var clergy_cards = [
	$Scale_Body/Scale_Left/Left_Clergy_Card,
	$Scale_Body/Scale_Right/Right_Clergy_Card
]

var _case:BaseCaseResource
var _aPicks
var _bPicks
var facACard:Card
var facBCard:Card

func _ready():
	for i in range(2):
		peasant_cards[i].countdown_for_selection = HoldDuration
		nobility_cards[i].countdown_for_selection = HoldDuration
		clergy_cards[i].countdown_for_selection = HoldDuration
		
		peasant_cards[i].connect("selected", _peasants_selected)
		nobility_cards[i].connect("selected", _nobility_selected)
		clergy_cards[i].connect("selected", _clergy_selected)
	##
##

func setup_factions(case:BaseCaseResource):
	for i in range(2):
		peasant_cards[i].visible = false
		nobility_cards[i].visible = false
		clergy_cards[i].visible = false
	##
	
	_case = case
	
	# A, B - pick a numer 1 through 10 :)
	_aPicks = randi_range(1, 10)
	_bPicks = randi_range(1, 10)
	
	var factionA = case.PARTY_A
	var factionB = case.PARTY_B
	
	# If a > b, a is on the left
	# If a <= b, b is on the left
	if _aPicks > _bPicks:
		_aPicks = 0
		_bPicks = 1
	else:
		_aPicks = 1
		_bPicks = 0
	##
	
	match factionA:
		GlobalData.Faction.CLERGY:
			facACard = clergy_cards[_aPicks]
		##
		GlobalData.Faction.NOBILITY:
			facACard = nobility_cards[_aPicks]
		##
		GlobalData.Faction.PEASANTS:
			facACard = peasant_cards[_aPicks]
		##
	##
	
	facACard.show_labels(case.PARTY_A_ARGUMENT, case.EFFECTS_A)
	facACard.visible = true
	
	match factionB:
		GlobalData.Faction.CLERGY:
			facBCard = clergy_cards[_bPicks]
		##
		GlobalData.Faction.NOBILITY:
			facBCard = nobility_cards[_bPicks]
		##
		GlobalData.Faction.PEASANTS:
			facBCard = peasant_cards[_bPicks]
		##
	##
	
	facBCard.show_labels(case.PARTY_B_ARGUMENT, case.EFFECTS_B)
	facBCard.visible = true
##

func _peasants_selected():
	if _case.PARTY_A == GlobalData.Faction.PEASANTS:
		facBCard.visible = false
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, false)
		##
	else:
		facACard.visible = false
		if _bPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, false)
		##
	##
##

func _clergy_selected():
	if _case.PARTY_A == GlobalData.Faction.CLERGY:
		facBCard.visible = false
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, false)
		##
	else:
		facACard.visible = false
		if _bPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, false)
		##
	##
##

func _nobility_selected():
	if _case.PARTY_A == GlobalData.Faction.NOBILITY:
		facBCard.visible = false
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, false)
		##
	else:
		facACard.visible = false
		if _bPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, false)
		##
	##
##

func _game_over_anim(card):
	pass
##
