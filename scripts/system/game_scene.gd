extends Node2D

## The number of turns the game should last.
@export var NUMBER_OF_TURNS:int = 25

## All cases in the game.
@export var CASES:Array[BaseCaseResource]

## Initial delay when this scene first loads 
@export var INITIAL_LOAD_DELAY:float = 1.2

@onready var _faction_stats = $FactionStats
@onready var _reputation_stats = $RepuationStats

## Current day.
var _curr_day:int = 1

## Called when node is in the tree.
func _ready():
	Verho.connect("loaded_scene", _loaded_scene)
	GlobalSignals.connect("update_stats_done", _update_stats_done)
	
	# Shuffle the cases
	CASES.shuffle()
	
	$Game_Overlay.connect("cases_left", readd_unpicked_cases)
	$Game_Overlay.connect("case_resolved", _confirm_case)
	$Game_Overlay.initialize(NUMBER_OF_TURNS)
	$Game_Overlay.show_day(_curr_day)
	$DelayTimer.start(INITIAL_LOAD_DELAY)
	
	$Game_Overlay.load_society_stats(_faction_stats.get_stats())
	$Game_Overlay.load_reputation_stats(_reputation_stats.get_reputations())
##

## Fired when the case has been submit.
func _confirm_case(effects:Array[BaseEffectResource]):
	_curr_day += 1
	
	var changes:Dictionary = {
		GlobalData.Faction.CLERGY: 0,
		GlobalData.Faction.NOBILITY: 0,
		GlobalData.Faction.PEASANTS: 0
	}
	
	# Update stats
	for eff in effects:
		# group:GlobalData.Faction, stat:GlobalData.Effects, value:in
		if eff.Affect == GlobalData.Effects.REPUTATION:
			changes[eff.Group] += eff.ValueChange
		else:
			if eff.RandomAmount:
				_faction_stats.update_value_for(eff.Group, eff.Affect,
												randi_range(eff.ValueRange.x, eff.ValueRange.y))
			else:
				_faction_stats.update_value_for(eff.Group, eff.Affect, eff.ValueChange)
			##
		##
	##
	
	$Game_Overlay.change_society_stats_by(effects)
	
	# Get the amount changes to reputations
	# ... And Change the reputations - all in one!
	for key in changes.keys():
		changes[key] += _faction_stats.get_faction_rep_change(key)
		_reputation_stats.set_reputation_for(key, changes[key])
	##
	
	print("Changes:", changes)
	print("Reps:", _reputation_stats.get_reputations())
	
	$Game_Overlay.change_reps_by(changes)
	
	# TODO: Save the current day -- let player back out without worry
	
	# TODO: call into Game_Overlay to start playing anims
##

## Called once the animation player is finished playing all the animations --
##	and confirmed by the player.
func _update_stats_done():
	# Did we lose? Did we win?
	var status:GlobalData.END_CONDITION = _reputation_stats.has_lost()
	
	if _curr_day == NUMBER_OF_TURNS:
		PlayerPrefs.game_end = 0
		Verho.change_scene("scenes/menus/hub_gameover", "", "BlackFade")
	elif status != GlobalData.END_CONDITION.NONE:
		if status == GlobalData.END_CONDITION.LOSS_CLERGY:
			PlayerPrefs.game_end = 3
		elif status == GlobalData.END_CONDITION.LOSS_NOBILITY:
			PlayerPrefs.game_end = 2
		elif status == GlobalData.END_CONDITION.LOSS_PEASANT:
			PlayerPrefs.game_end = 1
		##
		Verho.change_scene("scenes/menus/hub_gameover", "", "BlackFade")
	##
	
	# Otherwise, keep going...
	$Game_Overlay.show_day(_curr_day)
	$DelayTimer.start(INITIAL_LOAD_DELAY)
##

func _loaded_scene(scene_name):
	if scene_name != name:
		queue_free()
	##
##

func pick_cases() -> Array[BaseCaseResource]:
	var cases:Array[BaseCaseResource] = []
	
	while cases.size() < 3:
		var case = CASES.pick_random()
		CASES.remove_at(CASES.find(case))
		cases.append(case)
	##
	
	return cases
##

func readd_unpicked_cases(unpicked_cases:Array[BaseCaseResource]):
	for case in unpicked_cases:
		CASES.append(case)
	##
	
	# Shuffle everything
	CASES.shuffle()
##

func _on_delay_timer_timeout():
	$Game_Overlay.show_cases(pick_cases())
##
