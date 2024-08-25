extends Node2D

signal case_complete(case:BaseCaseResource, faction:GlobalData.Faction, case_description,
						effects:Array[BaseEffectResource])
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

var play_sound:bool = false
var clicking_sound

func _ready():
	GlobalSignals.connect("hovered_over_card", _mouse_hovering)
	GlobalSignals.connect("not_hovering", _mouse_not_hovering)
	
	left_mega_card.set_countdown_time(HoldDuration)
	right_mega_card.set_countdown_time(HoldDuration)
	
	left_mega_card.peasant_card.connect("selected", _card_selected)
	left_mega_card.peasant_card.connect("pressed_down", _left_selected)
	left_mega_card.peasant_card.connect("released", _left_released)
	
	left_mega_card.nobility_card.connect("selected", _card_selected)
	left_mega_card.nobility_card.connect("pressed_down", _left_selected)
	left_mega_card.nobility_card.connect("released", _left_released)
	
	left_mega_card.clergy_card.connect("selected", _card_selected)
	left_mega_card.clergy_card.connect("pressed_down", _left_selected)
	left_mega_card.clergy_card.connect("released", _left_released)
	
	right_mega_card.peasant_card.connect("selected", _card_selected)
	right_mega_card.peasant_card.connect("pressed_down", _right_selected)
	right_mega_card.peasant_card.connect("released", _right_released)
	
	right_mega_card.nobility_card.connect("selected", _card_selected)
	right_mega_card.nobility_card.connect("pressed_down", _right_selected)
	right_mega_card.nobility_card.connect("released", _right_released)
	
	right_mega_card.clergy_card.connect("selected", _card_selected)
	right_mega_card.clergy_card.connect("pressed_down", _right_selected)
	right_mega_card.clergy_card.connect("released", _right_released)
	
##

func enable_cards():
	left_mega_card.visible = true
	left_mega_card.enable()
	right_mega_card.visible = true
	right_mega_card.enable()
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
##

func _card_selected(faction:GlobalData.Faction, effects:Array[BaseEffectResource]):
	_mouse_not_hovering()
	ap_scale_control.play("RESET")
	left_mega_card.disable()
	right_mega_card.disable()
	
	if effects == _case.EFFECTS_A:
		emit_signal("case_complete", _case, faction, _case.PARTY_A_ARGUMENT, effects)
	else:
		emit_signal("case_complete", _case, faction, _case.PARTY_B_ARGUMENT, effects)
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
	play_sound = true
	ap_scale_control.play("press_left")
	clicking_sound = SoundManager.instance("scale", "clicking")
	
	#await get_tree().create_timer(1.4, false).timeout
	#
	#if play_sound == false:
		#return
	###
	#
	#SoundManager.play("scale", "thumb_scale")
	#clicking_sound.trigger()
##

func _left_released():
	clicking_sound.release()
	play_sound = false
	ap_scale_control.play("RESET")
##

func _right_selected():
	play_sound = true
	ap_scale_control.play("press_right")
	clicking_sound = SoundManager.instance("scale", "clicking")
	
	#await get_tree().create_timer(1.4, false).timeout
	#
	#if play_sound == false:
		#return
	###
	#
	#SoundManager.play("scale", "thumb_scale")
	#clicking_sound.trigger()
##

func _right_released():
	clicking_sound.release()
	play_sound = false
	ap_scale_control.play("RESET")
##

func play_scale_on_table():
	SoundManager.play_varied("scale", "scale_on_table", randf_range(0.9, 1.1))
##

func play_card_bounced():
	SoundManager.play_varied("scale", "card_bounce", randf_range(0.8, 1.1))
##

func play_card_bounced_quieter():
	SoundManager.play_varied("scale", "card_bounce", 1, linear_to_db(0.25))
##

func play_clicking_sound():
	clicking_sound.trigger()
##

func thumb_hit():
	SoundManager.play("scale", "thumb_scale")
##
