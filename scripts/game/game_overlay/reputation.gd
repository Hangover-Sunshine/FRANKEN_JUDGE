extends Control

@onready var rep_rates = {
	GlobalData.Faction.PEASANTS: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Peasantry_Rep_Rate,
	GlobalData.Faction.NOBILITY: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Nobility_Rep_Rate,
	GlobalData.Faction.CLERGY: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Clergy_Rep_Rate
}

@onready var bars = {
	GlobalData.Faction.PEASANTS: $Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Peasantry_Hbox/Peasantry_Rep_Bar,
	GlobalData.Faction.NOBILITY: $Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Nobility_Hbox/Nobility_Rep_Bar,
	GlobalData.Faction.CLERGY: $Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Clergy_Hbox/Clergy_Rep_Bar
}

var _changed_stats:Dictionary
var faction_one:int = -1
var faction_two:int = -1

func _ready():
	GlobalSignals.connect("hovered_over_card_fac", _hovered_over_card)
	GlobalSignals.connect("not_hovering", _not_hovering)
	
	for key in rep_rates.keys():
		rep_rates[key].visible = false
	##
##

func load_peasant_rep(rep):
	bars[0].value = rep
##

func load_nobility_rep(rep):
	bars[1].value = rep
##

func load_clergy_rep(rep):
	bars[2].value = rep
##

func change_bar_display(show_peasants:bool, show_nobility:bool, show_clergy:bool):
	bars[0].get_parent().visible = show_peasants
	if show_peasants:
		rep_rates[0].visible = true
		rep_rates[0].modulate = Color(1, 1, 1, 0)
		faction_one = 0
	else:
		rep_rates[0].visible = false
	##
	bars[1].get_parent().visible = show_nobility
	if show_nobility:
		rep_rates[1].visible = true
		rep_rates[1].modulate = Color(1, 1, 1, 0)
		if faction_one == -1:
			faction_one = 1
		else:
			faction_two = 1
		##
	else:
		rep_rates[1].visible = false
	##
	bars[2].get_parent().visible = show_clergy
	if show_clergy:
		rep_rates[2].visible = true
		rep_rates[2].modulate = Color(1, 1, 1, 0)
		if faction_one == -1:
			faction_one = 2
		else:
			faction_two = 2
		##
	else:
		rep_rates[2].visible = false
	##
##

func show_all_bars():
	faction_one = -1
	faction_two = -1
	bars[0].get_parent().visible = true
	bars[1].get_parent().visible = true
	bars[2].get_parent().visible = true
##

func _hovered_over_card(faction:GlobalData.Faction):
	if faction_two != -1:
		rep_rates[faction].text = "(+" + (GlobalData.TWO_NUM_DISPLAY % 10) + ")"
		rep_rates[faction].modulate = Color(1, 1, 1, 1)
		if faction == faction_one:
			rep_rates[faction_two].text = "(-" + (GlobalData.TWO_NUM_DISPLAY % 5) + ")"
			rep_rates[faction_two].modulate = Color(1, 1, 1, 1)
		else:
			rep_rates[faction_one].text = "(-" + (GlobalData.TWO_NUM_DISPLAY % 5) + ")"
			rep_rates[faction_one].modulate = Color(1, 1, 1, 1)
		##
	else:
		rep_rates[faction].text = "(+" + (GlobalData.TWO_NUM_DISPLAY % 5) + ")"
		rep_rates[faction].modulate = Color(1, 1, 1, 1)
	##
##

func _not_hovering():
	for key in rep_rates.keys():
		rep_rates[key].modulate = Color(1, 1, 1, 0)
	##
##

func show_changes():
	for key in _changed_stats.keys():
		if _changed_stats[key] < 0:
			rep_rates[key].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -_changed_stats[key])
		else:
			rep_rates[key].text = "+" + (GlobalData.TWO_NUM_DISPLAY % _changed_stats[key])
		##
		
		rep_rates[key].visible = true
	##
##

func hide_changes():
	_not_hovering()
##

func changes_to_reps(affected_reps):
	_changed_stats = affected_reps
##

func update_reputations():
	var changes_dict = {
		GlobalData.Faction.NOBILITY: floori(_changed_stats[GlobalData.Faction.NOBILITY] / 5)\
										if GlobalData.Faction.NOBILITY in _changed_stats else 0,
		GlobalData.Faction.PEASANTS : floori(_changed_stats[GlobalData.Faction.PEASANTS] / 5)\
							if GlobalData.Faction.PEASANTS in _changed_stats else 0,
		GlobalData.Faction.CLERGY : floori(_changed_stats[GlobalData.Faction.CLERGY] / 5)\
							if GlobalData.Faction.CLERGY in _changed_stats else 0
	}
	
	var times_through = 0
	
	while len(_changed_stats) > 0:
		for key in _changed_stats.keys():
			var change = 0
			
			if times_through < 4:
				if _changed_stats[key] < 0:
					change = max(_changed_stats[key], changes_dict[key])
					_changed_stats[key] -= change
					rep_rates[key].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -_changed_stats[key])
				else:
					change = min(_changed_stats[key], changes_dict[key])
					_changed_stats[key] -= change
					rep_rates[key].text = "+" + (GlobalData.TWO_NUM_DISPLAY % _changed_stats[key])
				##
			else:
				if _changed_stats[key] < 0:
					change = _changed_stats[key]
					_changed_stats[key] -= change
					rep_rates[key].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -_changed_stats[key])
				else:
					change = _changed_stats[key]
					_changed_stats[key] -= change
					rep_rates[key].text = "+" + (GlobalData.TWO_NUM_DISPLAY % _changed_stats[key])
				##
			##
			
			bars[key].value += change
			
			if _changed_stats[key] == 0:
				_changed_stats.erase(key)
			##
		##
		
		times_through += 1
		await get_tree().create_timer(0.2).timeout
	##
	
	hide_changes()
##
