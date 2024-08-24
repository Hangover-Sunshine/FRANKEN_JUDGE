extends Node2D

signal cases_left(cases:Array[BaseCaseResource])
signal case_resolved(effects:Array[BaseEffectResource])

@onready var ap_states = $AP_States
@onready var clergy_bolt = $ClergyBolt
@onready var nobility_bolt = $NobilityBolt
@onready var peasant_bolt = $PeasantBolt

var _cases:Array[BaseCaseResource]
var _case:BaseCaseResource
var _curr_day:int
var _case_ids:Array[int]
var _can_click_to_proceed:bool = false

# 0 = day, 1 = case pick, 2 = case brief, 3 = scales, 4 = results
var curr_screen:int = 0

var bg_chatter
var zapping

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
	
	await get_tree().create_timer(1, false).timeout
	SoundManager.play("env", "bell1")
	await get_tree().create_timer(2, false).timeout
	SoundManager.play("env", "bell2")
	await get_tree().create_timer(2.5, false).timeout
	SoundManager.play("env", "bell3")
##

func show_cases(cases:Array[BaseCaseResource]):
	$CasePick.disable()
	curr_screen = 1
	_cases = cases
	$CasePick.here_the_cases(cases)
	ap_states.play("Part2")
	bg_chatter = SoundManager.instance("env", "BGChatter")
	
	await get_tree().create_timer(0.5, false).timeout
	SoundManager.play("env", "swoosh")
	
	await get_tree().create_timer(0.8, false).timeout
	SoundManager.play("env", "swoosh")
	
	await get_tree().create_timer(0.5, false).timeout
	SoundManager.play_varied("folder", "in_place", randf_range(0.9, 1.1))
	
	await get_tree().create_timer(0.3, false).timeout
	SoundManager.play("env", "swoosh")
	
	await get_tree().create_timer(0.6, false).timeout
	SoundManager.play_varied("folder", "in_place", randf_range(0.9, 1.1))
	
	await get_tree().create_timer(0.9, false).timeout
	SoundManager.play_varied("folder", "in_place", randf_range(0.9, 1.1))
##

func _case_picked(case_id:int):
	SoundManager.play_varied("folder", "selected")
	zapping = SoundManager.instance("env", "zapping")
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
	$Reputation.change_bar_display(sp, sn, sc)
	$Society.change_table_display(sp, sn, sc)
##

func _show_sides():
	$Scale.setup_factions(_case)
	
	SoundManager.play("scale", "chain_pull")
	
	ap_states.play("Part4")
	
	await get_tree().create_timer(2, false).timeout
	
	SoundManager.play_varied("scale", "scale_on_table", randf_range(0.9, 1.1))
	
	await get_tree().create_timer(2.5, false).timeout
	SoundManager.play_varied("scale", "card_bounce", randf_range(0.8, 1.1))
	SoundManager.play_varied("scale", "card_bounce", randf_range(0.8, 1.1))
	
	await get_tree().create_timer(0.5, false).timeout
	SoundManager.play_varied("scale", "card_bounce", 1, linear_to_db(0.2))
	SoundManager.play_varied("scale", "card_bounce", 1, linear_to_db(0.2))
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
	
	var affected_parties:Array[GlobalData.Faction]
	
	$WinningCard.load_data(faction, case_desc, effects)
	
	for eff in effects:
		if not (eff.Group in affected_parties):
			affected_parties.append(eff.Group)
		##
	##
	
	var starts = [Vector2(600, 570), Vector2(600, 700), Vector2(600, 830)]
	var ends = Vector2(1110, 730)
	
	emit_signal("case_resolved", effects)
	
	ap_states.play("Part5")
	
	await get_tree().create_timer(1.7, false).timeout
	
	SoundManager.play_varied("ui", "swoosh", randf_range(0.8, 1.2))
	
	await get_tree().create_timer(2.8, false).timeout
	
	SoundManager.play_varied("ui", "swoosh", randf_range(0.6, 0.8))
	
	#await get_tree().create_timer(5.6).timeout
	await get_tree().create_timer(1.1, false).timeout
	
	# fire off the lightnings
	for group in affected_parties:
		if group == GlobalData.Faction.PEASANTS:
			peasant_bolt.set_start_position(starts[0])
			peasant_bolt.set_target_position(ends)
			peasant_bolt.Emit = true
			starts.pop_front()
		elif group == GlobalData.Faction.NOBILITY:
			nobility_bolt.set_start_position(starts[0])
			nobility_bolt.set_target_position(ends)
			nobility_bolt.Emit = true
			starts.pop_front()
		else:
			clergy_bolt.set_start_position(starts[0])
			clergy_bolt.set_target_position(ends)
			clergy_bolt.Emit = true
			starts.pop_front()
		##
	##
	zapping.trigger_varied(randf_range(0.7, 1))
	
	await get_tree().create_timer(0.9, false).timeout
	
	# re-add the modifiers
	$Society.show_changes_to_stats(effects)
	
	await get_tree().create_timer(2.3, false).timeout
	
	# stop
	zapping.release()
	zapping = SoundManager.instance("env", "zapping")
	peasant_bolt.Emit = false
	nobility_bolt.Emit = false
	clergy_bolt.Emit = false
	
	# hide the mods, update the table
	$Society.hide_changes_to_stats()
	$Society.update_stats()
##

func _tally_finished():
	ap_states.play("Part6")
	
	await get_tree().create_timer(0.2, false).timeout
	
	SoundManager.play_varied("ui", "swoosh", randf_range(0.6, 0.8))
	
	await get_tree().create_timer(1.3, false).timeout
	
	zapping.trigger_varied(randf_range(1, 1.4))
	
	peasant_bolt.set_start_position(Vector2(1450, 630))
	peasant_bolt.set_target_position(Vector2(860, 680))
	peasant_bolt.Emit = true
	
	nobility_bolt.set_start_position(Vector2(1450, 630))
	nobility_bolt.set_target_position(Vector2(860, 740))
	nobility_bolt.Emit = true
	
	clergy_bolt.set_start_position(Vector2(1450, 630))
	clergy_bolt.set_target_position(Vector2(860, 800))
	clergy_bolt.Emit = true
	
	await get_tree().create_timer(0.3, false).timeout
	
	# Show the tallies
	$Reputation.show_changes()
	
	await get_tree().create_timer(1.7, false).timeout
	
	zapping.release()
	peasant_bolt.Emit = false
	nobility_bolt.Emit = false
	clergy_bolt.Emit = false
	
	await get_tree().create_timer(1.0, false).timeout
	
	# Iterate, hide tallies once they hit 0
	$Reputation.update_reputations()
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
