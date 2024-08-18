extends Node2D

signal cases_left(cases:Array[BaseCaseResource])
signal case_resolved(effects:Array[BaseEffectResource])

@onready var ap_states = $AP_States

var _cases:Array[BaseCaseResource]
var _case:BaseCaseResource
var _curr_day:int
var _case_ids:Array[int]

# 0 = day, 1 = case pick, 2 = case brief, 3 = scales, 4 = results
var curr_screen:int = 0

func initialize(max_num_days:int):
	$LilDays.set_day_total(max_num_days)
	$BigDays.set_day_total(max_num_days)
	$CasePick.connect("case_picked", _case_picked)
	$Scale.connect("case_complete", _case_complete)
##

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and curr_screen == 2:
		curr_screen = 3
		_show_sides()
	##
##

# ============== UPPER HALF CONTROL ============== #
func load_society_stats(new_stats):
	$Society.load_peasant_stats(new_stats[GlobalData.Faction.PEASANTS])
	$Society.load_nobility_stats(new_stats[GlobalData.Faction.NOBILITY])
	$Society.load_clergy_stats(new_stats[GlobalData.Faction.CLERGY])
##

func update_society_stats(changes):
	pass
##

# ============== UPPER HALF CONTROL ============== #

# ============== BOTTOM HALF CONTROL ============== #
func show_day(curr_day):
	# Set both
	$LilDays.set_current_day(curr_day)
	$BigDays.set_current_day(curr_day)
	_curr_day = curr_day
	
	# Play big day
	ap_states.play("Part1")
##

func show_cases(cases:Array[BaseCaseResource]):
	curr_screen = 1
	_cases = cases
	$CasePick.here_the_cases(cases)
	ap_states.play("Part2")
##

func _case_picked(case_id:int):
	_case = _cases[case_id]
	_cases.remove_at(case_id)
	emit_signal("cases_left", _cases)
	$CaseBrief.show_brief(_curr_day, _case, _pick_rand_case_id())
	curr_screen = 2
	ap_states.play("Part3")
##

func _show_sides():
	$Scale.setup_factions(_case)
	ap_states.play("Part4")
##

func _pick_rand_case_id():
	var rand_id:int = randi_range(1000, 9999)
	
	while rand_id in _case_ids:
		rand_id = randi_range(1000, 9999)
	##
	
	_case_ids.append(rand_id)
	
	return rand_id
##

func _case_complete(case:BaseCaseResource, faction:GlobalData.Faction, chose_left:bool):
	print("seen!")
	
	var effects:Array[BaseEffectResource] = []
	
	if case.PARTY_A == case.PARTY_B:
		if chose_left:
			effects = case.EFFECTS_A
		else:
			effects = case.EFFECTS_B
		##
	else:
		if case.PARTY_A == faction:
			effects = case.EFFECTS_A
		else:
			effects = case.EFFECTS_B
		##
	##
	
	emit_signal("case_resolved", effects)
	
	# TODO: Play animation of things going away
##
# ============== BOTTOM HALF CONTROL ============== #
