extends Node2D

signal case_complete(case:BaseCaseResource, faction:GlobalData.Faction, chose_left:bool)
signal left_pressed
signal left_released
signal right_pressed
signal right_released

@export var HoldDuration:float = 3

@onready var left_mega_card = $Scale_Body/Scale_Left/LeftMegaCard
@onready var right_mega_card = $Scale_Body/Scale_Right/RightMegaCard
@onready var ap_scale_control = $AP_ScaleControl
@onready var hand_over_left = $HandOverLeft
@onready var hand_over_right = $HandOverRight

var _case:BaseCaseResource
var _aPicks
var _bPicks

func _ready():
	GlobalSignals.connect("hovered_over_card", _mouse_hovering)
	GlobalSignals.connect("not_hovering", _mouse_not_hovering)
	
	left_mega_card.set_countdown_time(HoldDuration)
	right_mega_card.set_countdown_time(HoldDuration)
	
	left_mega_card.peasant_card.connect("selected", _peasants_selected)
	left_mega_card.peasant_card.connect("pressed_down", _left_selected)
	left_mega_card.peasant_card.connect("released", _left_released)
	left_mega_card.nobility_card.connect("selected", _nobility_selected)
	left_mega_card.nobility_card.connect("pressed_down", _left_selected)
	left_mega_card.nobility_card.connect("released", _left_released)
	left_mega_card.clergy_card.connect("selected", _clergy_selected)
	left_mega_card.clergy_card.connect("pressed_down", _left_selected)
	left_mega_card.clergy_card.connect("released", _left_released)
	
	right_mega_card.peasant_card.connect("selected", _peasants_selected)
	right_mega_card.peasant_card.connect("pressed_down", _right_selected)
	right_mega_card.peasant_card.connect("released", _right_released)
	
	right_mega_card.nobility_card.connect("selected", _nobility_selected)
	right_mega_card.nobility_card.connect("pressed_down", _right_selected)
	right_mega_card.nobility_card.connect("released", _right_released)
	
	right_mega_card.clergy_card.connect("selected", _clergy_selected)
	right_mega_card.clergy_card.connect("pressed_down", _right_selected)
	right_mega_card.clergy_card.connect("released", _right_released)
	
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
	_mouse_not_hovering()
	ap_scale_control.play("RESET")
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
	_mouse_not_hovering()
	ap_scale_control.play("RESET")
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
	_mouse_not_hovering()
	ap_scale_control.play("RESET")
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

func _mouse_hovering(effects):
	if effects == _case.EFFECTS_A:
		if _aPicks == 0:
			hand_over_left.visible = true
		else:
			hand_over_right.visible = true
	else:
		if _bPicks == 0:
			hand_over_left.visible = true
		else:
			hand_over_right.visible = true
	##
##

func _mouse_not_hovering():
	hand_over_left.visible = false
	hand_over_right.visible = false
##

func _left_selected():
	ap_scale_control.play("press_left")
##

func _left_released():
	ap_scale_control.play("RESET")
##

func _right_selected():
	ap_scale_control.play("press_right")
##

func _right_released():
	ap_scale_control.play("RESET")
##
