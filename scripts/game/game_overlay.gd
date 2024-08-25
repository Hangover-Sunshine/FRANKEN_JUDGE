extends Node2D

signal cases_left(cases:Array[BaseCaseResource])
signal case_resolved(effects:Array[BaseEffectResource], faction:GlobalData.Faction)

@onready var ap_states = $AP_States

var _cases:Array[BaseCaseResource]
var _case:BaseCaseResource
var _curr_day:int
var _case_ids:Array[int]
var _can_click_to_proceed:bool = false

# 0 = day, 1 = case pick, 2 = case brief, 3 = scales, 4 = results
var curr_screen:int = 0

var bg_chatter

func initialize(max_num_days:int):
	$LilDays.set_day_total(max_num_days)
	$BigDays.set_day_total(max_num_days)
	$CasePick.connect("case_picked", _case_picked)
	$Scale.connect("case_complete", _case_complete)
	$WinningCard.connect("done_loading_society", _tally_finished)
##

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and curr_screen == 2\
		and _can_click_to_proceed:
		curr_screen = 3
		SoundManager.play("ui", "gavel_smack")
		_show_sides()
	##
##

# ============== UPPER HALF CONTROL ============== #
func load_society_stats(stats):
	$Society.load_peasant_stats(stats[GlobalData.Faction.PEASANTS])
	$Society.load_nobility_stats(stats[GlobalData.Faction.NOBILITY])
	$Society.load_clergy_stats(stats[GlobalData.Faction.CLERGY])
##

func change_society_stats_by(changes):
	$Society.changes_to_stats(changes)
##

func load_reputation_stats(reps):
	$Reputation.load_peasant_rep(reps[GlobalData.Faction.PEASANTS])
	$Reputation.load_nobility_rep(reps[GlobalData.Faction.NOBILITY])
	$Reputation.load_clergy_rep(reps[GlobalData.Faction.CLERGY])
##

func change_reps_by(changes):
	$Reputation.changes_to_reps(changes)
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
	
	$Background.change_hater()
##

func show_cases(cases:Array[BaseCaseResource]):
	$CasePick.disable()
	curr_screen = 1
	_cases = cases
	$CasePick.here_the_cases(cases)
	ap_states.play("Part2")
	bg_chatter = SoundManager.instance("env", "BGChatter")
##

func _case_picked(case_id:int):
	SoundManager.play_varied("folder", "selected")
	bg_chatter.trigger()
	_case = _cases[case_id]
	_cases.remove_at(case_id)
	emit_signal("cases_left", _cases)
	$CaseBrief.show_brief(_curr_day, _case, _pick_rand_case_id())
	curr_screen = 2
	_can_click_to_proceed = false
	ap_states.play("Part3")
	
	var sp:bool = _case.PARTY_A == GlobalData.Faction.PEASANTS or _case.PARTY_B == GlobalData.Faction.PEASANTS
	var sn:bool = _case.PARTY_A == GlobalData.Faction.NOBILITY or _case.PARTY_B == GlobalData.Faction.NOBILITY
	var sc:bool = _case.PARTY_A == GlobalData.Faction.CLERGY or _case.PARTY_B == GlobalData.Faction.CLERGY
	# Reputation is easy - it immediately affects one of the two cards
	$Reputation.change_bar_display(sp, sn, sc)
	
	# Now we get into effects, where a one card might affect more...
	sp = false
	sn = false
	sc = false
	
	for eff in _case.EFFECTS_A:
		if eff.Group == GlobalData.Faction.PEASANTS:
			sp = true
		elif eff.Group == GlobalData.Faction.CLERGY:
			sc = true
		else:
			sn = true
		##
	##
	
	for eff in _case.EFFECTS_B:
		if eff.Group == GlobalData.Faction.PEASANTS:
			sp = true
		elif eff.Group == GlobalData.Faction.CLERGY:
			sc = true
		else:
			sn = true
		##
	##
	
	$Society.change_table_display(sp, sn, sc)
##

func _show_sides():
	$Scale.setup_factions(_case)
	
	SoundManager.play("scale", "chain_pull")
	
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

func _case_complete(case, faction:GlobalData.Faction, case_desc, effects:Array[BaseEffectResource]):
	$Reputation.show_all_bars()
	$Society.show_all()
	bg_chatter.release()
	SoundManager.play("env", "CrowdGasp")
	
	var affected_parties:Array[GlobalData.Faction] = []
	
	$WinningCard.load_data(faction, case_desc, effects)
	$LightningController.setup(faction, effects)
	
	for eff in effects:
		if not (eff.Group in affected_parties):
			affected_parties.append(eff.Group)
		##
	##
	
	$Society.changes_to_stats(effects)
	
	emit_signal("case_resolved", effects, faction)
	
	ap_states.play("Part5")
##

func _tally_finished():
	ap_states.play("Part6")
##
# ============== BOTTOM HALF CONTROL ============== #

func _on_ap_states_animation_finished(anim_name):
	if anim_name == "Part1":
		show_cases(get_parent().pick_cases())
	##
	
	if anim_name == "Part2":
		$CasePick.enable()
	##
	
	if anim_name == "Part3":
		_can_click_to_proceed = true
	##
	
	if anim_name == "Part4":
		$Scale.enable_cards()
	##
	
	if anim_name == "Part5":
		_tally_finished()
	##
	
	if anim_name == "Part6":
		GlobalSignals.emit_signal("update_stats_done")
	##
##
