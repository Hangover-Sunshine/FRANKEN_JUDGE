extends Node2D

signal update_stats_done

## The number of turns the game should last.
@export var NUMBER_OF_TURNS:int = 25

## All cases in the game.
@export var CASES:Array[BaseCaseResource]

## Initial delay when this scene first loads 
@export var INITIAL_LOAD_DELAY:float = 1.2

## Current day.
var _curr_day:int = 1

@onready var _faction_stats = $FactionStats
@onready var _reputation_stats = $RepuationStats

## Called when node is in the tree.
func _ready():
	Verho.connect("loaded_scene", _loaded_scene)
	#connect("confirm_case", _confirm_case)
	connect("update_stats_done", _update_stats_done)
	
	# Shuffle the cases
	CASES.shuffle()
	
	$Game_Overlay.connect("cases_left", readd_unpicked_cases)
	$Game_Overlay.connect("case_resolved", _confirm_case)
	$Game_Overlay.initialize(NUMBER_OF_TURNS)
	$Game_Overlay.show_day(_curr_day)
	$DelayTimer.start(INITIAL_LOAD_DELAY)
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
	
	# Get the amount changes to reputations
	# ... And Change the reputations - all in one!
	for key in changes.keys():
		changes[key] += _faction_stats.get_faction_rep_change(key)
		_reputation_stats.set_reputation_for(key, changes[key])
	##
	
	# TODO: Save the current day -- let player back out without worry
	
	# TODO: Send off for animations :)
##

## Called once the animation player is finished playing all the animations --
##	and confirmed by the player.
func _update_stats_done():
	# Did we lose? Did we win?
	var status:GlobalData.END_CONDITION = _reputation_stats.has_lost()
	
	if _curr_day == NUMBER_OF_TURNS:
		if status == GlobalData.END_CONDITION.LOSS_ALL:
			pass # You just lose
		elif status == GlobalData.END_CONDITION.LOSS_CLERGY or \
				status == GlobalData.END_CONDITION.LOSS_NOBILITY or \
				status == GlobalData.END_CONDITION.LOSS_PEASANT:
				pass # Win, but barely
			##
		##
		
		pass # Win
	elif status != GlobalData.END_CONDITION.NONE:
		pass # Just lost, that's it
	##
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
