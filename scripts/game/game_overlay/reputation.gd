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

func _ready():
	GlobalSignals.connect("hovered_over_card", _hovered_over_card)
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
	bars[1].get_parent().visible = show_nobility
	bars[2].get_parent().visible = show_clergy
##

func show_all_bars():
	bars[0].get_parent().visible = true
	bars[1].get_parent().visible = true
	bars[2].get_parent().visible = true
##

func _hovered_over_card(effects:Array[BaseEffectResource]):
	for eff in effects:
		if eff.Affect != GlobalData.Effects.REPUTATION:
			continue
		##
		
		rep_rates[eff.Group].visible = true
		
		if eff.ValueChange < 0:
			rep_rates[eff.Group].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -eff.ValueChange)
		else:
			rep_rates[eff.Group].text = "+" + (GlobalData.TWO_NUM_DISPLAY % eff.ValueChange)
		##
	##
##

func _not_hovering():
	for key in rep_rates.keys():
		rep_rates[key].visible = false
	##
##

func changes_to_reps(affected_reps):
	_changed_stats = affected_reps
##

func update_reputations():
	for key in _changed_stats.keys():
		bars[key].value += _changed_stats[key]
	##
##
