extends Node

# 0 - 2: -_[2], 3 - 4: -_[1], 5 - 6: _[0], 7 - 8: _[1], 9 - 10: _[2]
# Convert to %s for tax
const _REP_CHANGE_FOR = {
	"favored": [1, 1, 3],
	"unfavored": [0, 1, 2]
}

## Issues favored by each faction -- impacts reputation loss/gain by satisfying them.
const FAVORED_ISSUES = {
	GlobalData.Faction.NOBILITY: [
		GlobalData.Effects.TAX, GlobalData.Effects.LITERACY,
		GlobalData.Effects.POLICING,
		GlobalData.Effects.LABOR
	],
	GlobalData.Faction.PEASANTS: [
		GlobalData.Effects.TAX, GlobalData.Effects.LITERACY,
		GlobalData.Effects.LABOR,
		GlobalData.Effects.HEALTHCARE
	],
	GlobalData.Faction.CLERGY:   [
		GlobalData.Effects.TAX, GlobalData.Effects.LITERACY,
		GlobalData.Effects.POLICING,
		GlobalData.Effects.HEALTHCARE
	],
}

## Various town stats to keep track of.
var _town_stats:Dictionary = {
	GlobalData.Faction.NOBILITY: {
		GlobalData.Effects.TAX: 30,
		GlobalData.Effects.LITERACY: 5,
		GlobalData.Effects.POLICING: 5,
		GlobalData.Effects.LABOR: 5,
		GlobalData.Effects.HEALTHCARE: 5
	},
	GlobalData.Faction.PEASANTS: {
		GlobalData.Effects.TAX: 100,
		GlobalData.Effects.LITERACY: 5,
		GlobalData.Effects.POLICING: 5,
		GlobalData.Effects.LABOR: 5,
		GlobalData.Effects.HEALTHCARE: 5
	},
	GlobalData.Faction.CLERGY: {
		GlobalData.Effects.TAX: 20,
		GlobalData.Effects.LITERACY: 5,
		GlobalData.Effects.POLICING: 5,
		GlobalData.Effects.LABOR: 5,
		GlobalData.Effects.HEALTHCARE: 5
	}
}

func _ready():
	for fac in range(3):
		for stat in range(1, 4):
			_town_stats[fac][stat] += (1 + randi_range(0, 1) * -2) * randi_range(0, 2)
		##
	##
##

func update_value_for(group:GlobalData.Faction, stat:GlobalData.Effects, value:int):
	var val = _town_stats[group][stat] + value
	
	# min "take max or current value"
	# max "take min or current value"
	if stat == GlobalData.Effects.TAX:
		_town_stats[group][stat] = min(100, max(0, val))
	else:
		_town_stats[group][stat] = min(10, max(0, val))
	##
##

## Get stats.
func get_stats():
	return _town_stats
##

## Get stats for a group.
func get_stats_for(group:GlobalData.Faction):
	return _town_stats[group]
##

## Get a specific stat for a group.
func get_stat_for(group:GlobalData.Faction, stat:GlobalData.Effects):
	return _town_stats[group][stat]
##

## Get the change in the faction's ideals of the player.
func get_faction_rep_change(group:GlobalData.Faction) -> int:
	var vals = _town_stats[group]
	var fissues = FAVORED_ISSUES[group]
	
	var rep_change:int = 0
	
	# everyone cares about taxes -- and they're 0 - 100, not 0 - 10
	if vals[GlobalData.Effects.TAX] <= 29: # -5
		rep_change = 3
	elif vals[GlobalData.Effects.TAX] >= 30 and vals[GlobalData.Effects.TAX] <= 49: # -2
		rep_change = 1
	elif vals[GlobalData.Effects.TAX] >= 50 and vals[GlobalData.Effects.TAX] < 69: # 0
		rep_change = 0
	elif vals[GlobalData.Effects.TAX] >= 70 and vals[GlobalData.Effects.TAX] < 89: # 2
		rep_change = -1
	else: # 5
		rep_change = -3
	##
	
	for key in vals.keys():
		if key == GlobalData.Effects.TAX:
			continue
		##
		
		var val = vals[key]
		var change_arr = _REP_CHANGE_FOR["favored"] if key in fissues else _REP_CHANGE_FOR["unfavored"]
		
		if val <= 2:
			rep_change -= change_arr[2]
		elif val >= 3 and val <= 4:
			rep_change -= change_arr[1]
		elif val >= 5 and val <= 6:
			rep_change += change_arr[0]
		elif val >= 7 and val <= 8:
			rep_change += change_arr[1]
		else:
			rep_change += change_arr[2]
		##
	##
	
	return rep_change
##
