extends Node2D

signal case_complete(case:BaseCaseResource, faction:GlobalData.Faction, chose_left:bool)

@export var HoldDuration:float = 3

@onready var left_mega_card = $Scale_Body/Scale_Left/LeftMegaCard
@onready var right_mega_card = $Scale_Body/Scale_Right/RightMegaCard

var _case:BaseCaseResource
var _aPicks
var _bPicks

func _ready():
	left_mega_card.set_countdown_time(HoldDuration)
	right_mega_card.set_countdown_time(HoldDuration)
	
	left_mega_card.peasant_card.connect("selected", _peasants_selected)
	left_mega_card.nobility_card.connect("selected", _nobility_selected)
	left_mega_card.clergy_card.connect("selected", _clergy_selected)
	
	right_mega_card.peasant_card.connect("selected", _peasants_selected)
	right_mega_card.nobility_card.connect("selected", _nobility_selected)
	right_mega_card.clergy_card.connect("selected", _clergy_selected)
##

func setup_factions(case:BaseCaseResource):
	left_mega_card.hide_all()
	right_mega_card.hide_all()
	
	_case = case
	
	# A, B - pick a numer 1 through 10 :)
	_aPicks = randi_range(1, 10)
	_bPicks = randi_range(1, 10)
	
	# If a > b, a is on the left
	# If a <= b, b is on the left
	if _aPicks > _bPicks:
		_aPicks = 0
		left_mega_card.show_labels(case.PARTY_A, case.PARTY_A_ARGUMENT, case.EFFECTS_A)
		
		_bPicks = 1
		right_mega_card.show_labels(case.PARTY_B, case.PARTY_B_ARGUMENT, case.EFFECTS_B)
	else:
		_aPicks = 1
		right_mega_card.show_labels(case.PARTY_A, case.PARTY_A_ARGUMENT, case.EFFECTS_A)
		
		_bPicks = 0
		left_mega_card.show_labels(case.PARTY_B, case.PARTY_B_ARGUMENT, case.EFFECTS_B)
	##
	
	left_mega_card.visible = true
	left_mega_card.enable()
	right_mega_card.visible = true
	right_mega_card.enable()
##

func _peasants_selected():
	if _case.PARTY_A == GlobalData.Faction.PEASANTS:
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, false)
		##
	else:
		if _bPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.PEASANTS, false)
		##
	##
##

func _clergy_selected():
	if _case.PARTY_A == GlobalData.Faction.CLERGY:
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, false)
		##
	else:
		if _bPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.CLERGY, false)
		##
	##
##

func _nobility_selected():
	if _case.PARTY_A == GlobalData.Faction.NOBILITY:
		if _aPicks == 0:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, true)
		else:
			emit_signal("case_complete", _case, GlobalData.Faction.NOBILITY, false)
		##
	else:
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
