extends Control

@onready var peasant_stat_labels = [
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Tax_Hbox/Peasant_Tax,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lit_Hbox/Peasant_Lit,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Pol_Hbox/Peasant_Pol,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lab_Hbox/Peasant_Lab_Rank,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Hea_Hbox/Peasant_Hea_Rank
]

@onready var peasant_change_hover = {
	GlobalData.Effects.TAX: $Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Tax_Hbox/Peasant_Tax_GL,
	GlobalData.Effects.LITERACY: $Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lit_Hbox/Peasant_Lit_GL,
	GlobalData.Effects.POLICING: $Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Pol_Hbox/Peasant_Pol_GL,
	GlobalData.Effects.LABOR: $Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lab_Hbox/Peasant_Lab_GL,
	GlobalData.Effects.HEALTHCARE: $Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Hea_Hbox/Peasant_Hea_GL
}

@onready var nobility_stat_labels = [
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Tax_Hbox/Nobility_Tax,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lit_Hbox/Nobility_Lit,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Pol_Hbox/Nobility_Pol,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lab_Hbox/Nobility_Lab_Rank,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Hea_Hbox/Nobility_Hea_Rank
]

@onready var nobility_change_hover = {
	GlobalData.Effects.TAX: $Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Tax_Hbox/Nobility_Tax_GL,
	GlobalData.Effects.LITERACY: $Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lit_Hbox/Nobility_Lit_GL,
	GlobalData.Effects.POLICING: $Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Pol_Hbox/Nobility_Pol_GL,
	GlobalData.Effects.LABOR: $Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lab_Hbox/Nobility_Lab_GL,
	GlobalData.Effects.HEALTHCARE: $Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Hea_Hbox/Nobility_Hea_GL
}

@onready var clergy_stat_labels = [
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Tax_Hbox/Clergy_Tax,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lit_Hbox/Clergy_Lit,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Pol_Hbox/Clergy_Pol,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lab_Hbox/Clergy_Lab_Rank,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Hea_Hbox/Clergy_Hea_Rank
]

@onready var clergy_change_hover = {
	GlobalData.Effects.TAX: $Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Tax_Hbox/Clergy_Tax_GL,
	GlobalData.Effects.LITERACY: $Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lit_Hbox/Clergy_Lit_GL,
	GlobalData.Effects.POLICING: $Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Pol_Hbox/Clergy_Pol_GL,
	GlobalData.Effects.LABOR: $Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lab_Hbox/Clergy_Lab_GL,
	GlobalData.Effects.HEALTHCARE: $Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Hea_Hbox/Clergy_Hea_GL
}

var internal_stats_rep = {}

var _effects:Array[BaseEffectResource]

func _ready():
	GlobalSignals.connect("hovered_over_card", _hovered_over_card)
	GlobalSignals.connect("not_hovering", _not_hovering)
##

func load_peasant_stats(pstats):
	internal_stats_rep[GlobalData.Faction.PEASANTS] = pstats.duplicate()
	peasant_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % pstats[GlobalData.Effects.TAX]) + "%"
	peasant_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.LITERACY])
	peasant_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.POLICING])
	peasant_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.LABOR])
	peasant_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.HEALTHCARE])
##

func load_nobility_stats(nstats):
	internal_stats_rep[GlobalData.Faction.NOBILITY] = nstats.duplicate()
	nobility_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % nstats[GlobalData.Effects.TAX]) + "%"
	nobility_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.LITERACY])
	nobility_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.POLICING])
	nobility_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.LABOR])
	nobility_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.HEALTHCARE])
##

func load_clergy_stats(cstats):
	internal_stats_rep[GlobalData.Faction.CLERGY] = cstats.duplicate()
	clergy_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % cstats[GlobalData.Effects.TAX]) + "%"
	clergy_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.LITERACY])
	clergy_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.POLICING])
	clergy_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.LABOR])
	clergy_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.HEALTHCARE])
##

func _hovered_over_card(effects:Array[BaseEffectResource]):
	_effects = effects
	
	for eff in _effects:
		if eff.Group == GlobalData.Faction.PEASANTS:
			peasant_change_hover[eff.Affect].visible = false
			if eff.Affect == GlobalData.Effects.TAX:
				peasant_change_hover[eff.Affect].text = GlobalData.THREE_NUM_DISPLAY % eff.ValueChange
			else:
				peasant_change_hover[eff.Affect].text = GlobalData.TWO_NUM_DISPLAY % eff.ValueChange
			##
		elif eff.Group == GlobalData.Faction.NOBILITY:
			nobility_change_hover[eff.Affect].visible = false
			if eff.Affect == GlobalData.Effects.TAX:
				nobility_change_hover[eff.Affect].text = GlobalData.THREE_NUM_DISPLAY % eff.ValueChange
			else:
				nobility_change_hover[eff.Affect].text = GlobalData.TWO_NUM_DISPLAY % eff.ValueChange
			##
		else:
			clergy_change_hover[eff.Affect].visible = false
			if eff.Affect == GlobalData.Effects.TAX:
				clergy_change_hover[eff.Affect].text = GlobalData.THREE_NUM_DISPLAY % eff.ValueChange
			else:
				clergy_change_hover[eff.Affect].text = GlobalData.TWO_NUM_DISPLAY % eff.ValueChange
			##
		##
	##
##

func _not_hovering():
	for key in peasant_change_hover.keys():
		peasant_change_hover[key].visible = false
		nobility_change_hover[key].visible = false
		clergy_change_hover[key].visible = false
	##
	_effects = []
##
