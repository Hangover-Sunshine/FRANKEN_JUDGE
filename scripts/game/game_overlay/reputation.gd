extends Control

@onready var reputation_rates_vbox = $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox

@onready var rep_rates = {
	GlobalData.Faction.PEASANTS: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Peasantry_Rep_Rate,
	GlobalData.Faction.NOBILITY: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Nobility_Rep_Rate,
	GlobalData.Faction.CLERGY: $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox/Clergy_Rep_Rate
}

@onready var bars = [
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Peasantry_Hbox/Peasantry_Rep_Bar,
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Nobility_Hbox/Nobility_Rep_Bar,
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Clergy_Hbox/Clergy_Rep_Bar
]

func _ready():
	GlobalSignals.connect("hovered_over_card", _hovered_over_card)
	GlobalSignals.connect("not_hovering", _not_hovering)
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

func _hovered_over_card(effects:Array[BaseEffectResource]):
	for eff in effects:
		if eff.Affect != GlobalData.Effects.REPUTATION:
			continue
		##
		
		rep_rates[eff.Group].visible = true
		
		if eff.ValueChange < 0:
			rep_rates[eff.Group].text = GlobalData.TWO_NUM_DISPLAY % eff.ValueChange
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

func update_reps(affected_reps):
	pass
##
