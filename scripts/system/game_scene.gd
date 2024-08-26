extends Node2D

## The number of turns the game should last.
@export var NUMBER_OF_TURNS:int = 25

## All cases in the game.
@export var CASES:Array[BaseCaseResource]

@onready var _faction_stats = $FactionStats
@onready var _reputation_stats = $RepuationStats

## Current day.
var _curr_day:int = 1

## Called when node is in the tree.
func _ready():
	Verho.connect("loaded_scene", _loaded_scene)
	GlobalSignals.connect("update_stats_done", _update_stats_done)
	$PauseLayer/HubPause.connect("unpause_by_button", _unpaused_by_button)
	
	MusicManager.set_volume(linear_to_db(1.0))
	
	# Shuffle the cases
	CASES.shuffle()
	
	$Game_Overlay.connect("cases_left", readd_unpicked_cases)
	$Game_Overlay.connect("case_resolved", _confirm_case)
	$Game_Overlay.initialize(NUMBER_OF_TURNS)
	$Game_Overlay.show_day(_curr_day)
	
	$Game_Overlay.load_society_stats(_faction_stats.get_stats())
	$Game_Overlay.load_reputation_stats(_reputation_stats.get_reputations())
##

func _input(event):
	if event is InputEventKey and event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		$PauseLayer.visible = get_tree().paused
	##
##

func _unpaused_by_button():
	get_tree().paused = false
	$PauseLayer.visible = false
##

## Fired when the case has been submit.
func _confirm_case(effects:Array[BaseEffectResource],
					winner:GlobalData.Faction, loser:GlobalData.Faction):
	_curr_day += 1
	
	var changes:Dictionary = {
		GlobalData.Faction.CLERGY: 0,
		GlobalData.Faction.NOBILITY: 0,
		GlobalData.Faction.PEASANTS: 0
	}
	
	if winner != loser:
		changes[winner] += 10
		changes[loser] -= 5
	else:
		changes[winner] += 5
	##
	
	# Update stats
	for eff in effects:
		_faction_stats.update_value_for(eff.Group, eff.Affect, eff.ValueChange)
	##
	
	$Game_Overlay.change_society_stats_by(effects)
	
	# Get the amount changes to reputations
	# ... And Change the reputations - all in one!
	for key in changes.keys():
		changes[key] += _faction_stats.get_faction_rep_change(key)
		_reputation_stats.set_reputation_for(key, changes[key])
	##
	
	$Game_Overlay.change_reps_by(changes)
##

## Called once the animation player is finished playing all the animations --
##	and confirmed by the player.
func _update_stats_done():
	# Did we lose? Did we win?
	var status:GlobalData.END_CONDITION = _reputation_stats.has_lost()
	
	if _curr_day > NUMBER_OF_TURNS:
		MusicManager.set_volume(linear_to_db(0.4))
		PlayerPrefs.game_end = 0
		Verho.change_scene("scenes/menus/hub_gameover", "", "BlackFade")
		return
	elif status != GlobalData.END_CONDITION.NONE:
		if status == GlobalData.END_CONDITION.LOSS_CLERGY:
			PlayerPrefs.game_end = 3
		elif status == GlobalData.END_CONDITION.LOSS_NOBILITY:
			PlayerPrefs.game_end = 2
		elif status == GlobalData.END_CONDITION.LOSS_PEASANT:
			PlayerPrefs.game_end = 1
		##
		MusicManager.set_volume(linear_to_db(0.4))
		Verho.change_scene("scenes/menus/hub_gameover", "", "BlackFade")
		return
	##
	
	$Game_Overlay/Background.next_faction = $RepuationStats.get_angriest_faction()
	# Otherwise, keep going...
	$Game_Overlay.show_day(_curr_day)
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
