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
var _changed_stats:Array[BaseEffectResource]

func _ready():
	GlobalSignals.connect("hovered_over_card", _hovered_over_card)
	GlobalSignals.connect("not_hovering", _not_hovering)
##

func load_peasant_stats(pstats):
	internal_stats_rep[GlobalData.Faction.PEASANTS] = pstats.duplicate()
	update_peasants_display()
##

func load_nobility_stats(nstats):
	internal_stats_rep[GlobalData.Faction.NOBILITY] = nstats.duplicate()
	update_nobility_display()
##

func load_clergy_stats(cstats):
	internal_stats_rep[GlobalData.Faction.CLERGY] = cstats.duplicate()
	update_clergy_display()
##

func change_table_display(show_peasants:bool, show_nobility:bool, show_clergy:bool):
	peasant_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = show_peasants
	nobility_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = show_nobility
	clergy_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = show_clergy
##

func show_all():
	peasant_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = true
	nobility_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = true
	clergy_stat_labels[0].get_parent().get_parent().get_parent().get_parent().visible = true
##

func _hovered_over_card(effects:Array[BaseEffectResource]):
	for eff in effects:
		if eff.Affect == GlobalData.Effects.REPUTATION:
			continue
		##
		
		if eff.Group == GlobalData.Faction.PEASANTS:
			peasant_change_hover[eff.Affect].visible = true
			
			if eff.ValueChange < 0:
				if eff.Affect == GlobalData.Effects.TAX:
					peasant_change_hover[eff.Affect].text = "-" + (GlobalData.THREE_NUM_DISPLAY % -eff.ValueChange) + "%"
				else:
					peasant_change_hover[eff.Affect].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -eff.ValueChange)
				##
			else:
				if eff.Affect == GlobalData.Effects.TAX:
					peasant_change_hover[eff.Affect].text = "+" + (GlobalData.THREE_NUM_DISPLAY % eff.ValueChange) + "%"
				else:
					peasant_change_hover[eff.Affect].text = "+" + (GlobalData.TWO_NUM_DISPLAY % eff.ValueChange)
				##
			##
		elif eff.Group == GlobalData.Faction.NOBILITY:
			nobility_change_hover[eff.Affect].visible = true
			
			if eff.ValueChange < 0:
				if eff.Affect == GlobalData.Effects.TAX:
					nobility_change_hover[eff.Affect].text = "-" + (GlobalData.THREE_NUM_DISPLAY % -eff.ValueChange) + "%"
				else:
					nobility_change_hover[eff.Affect].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -eff.ValueChange)
				##
			else:
				if eff.Affect == GlobalData.Effects.TAX:
					nobility_change_hover[eff.Affect].text = "+" + (GlobalData.THREE_NUM_DISPLAY % eff.ValueChange) + "%"
				else:
					nobility_change_hover[eff.Affect].text = "+" + (GlobalData.TWO_NUM_DISPLAY % eff.ValueChange)
				##
			##
		else:
			clergy_change_hover[eff.Affect].visible = true
			
			if eff.ValueChange < 0:
				if eff.Affect == GlobalData.Effects.TAX:
					clergy_change_hover[eff.Affect].text = "-" + (GlobalData.THREE_NUM_DISPLAY % -eff.ValueChange) + "%"
				else:
					clergy_change_hover[eff.Affect].text = "-" + (GlobalData.TWO_NUM_DISPLAY % -eff.ValueChange)
				##
			else:
				if eff.Affect == GlobalData.Effects.TAX:
					clergy_change_hover[eff.Affect].text = "+" + (GlobalData.THREE_NUM_DISPLAY % eff.ValueChange) + "%"
				else:
					clergy_change_hover[eff.Affect].text = "+" + (GlobalData.TWO_NUM_DISPLAY % eff.ValueChange)
				##
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
##

func changes_to_stats(affected_stats):
	_changed_stats = affected_stats
##

func show_changes_to_stats():
	_hovered_over_card(_changed_stats)
##

func hide_changes_to_stats():
	_not_hovering()
##

func update_stats():
	for eff in _changed_stats:
		if eff.Affect == GlobalData.Effects.REPUTATION:
			continue
		##
		
		internal_stats_rep[eff.Group][eff.Affect] += eff.ValueChange
		
		var max_limit = 10
		if eff.Affect == GlobalData.Effects.TAX:
			max_limit = 100
		##
		internal_stats_rep[eff.Group][eff.Affect] = \
				min(max_limit, max(0, internal_stats_rep[eff.Group][eff.Affect]))
	##
	
	# update display
	update_peasants_display()
	update_nobility_display()
	update_clergy_display()
##

func update_peasants_display():
	peasant_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.PEASANTS][GlobalData.Effects.TAX]) + "%"
	peasant_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.PEASANTS][GlobalData.Effects.LITERACY])
	peasant_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.PEASANTS][GlobalData.Effects.POLICING])
	peasant_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.PEASANTS][GlobalData.Effects.LABOR])
	peasant_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.PEASANTS][GlobalData.Effects.HEALTHCARE])
##

func update_nobility_display():
	nobility_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.NOBILITY][GlobalData.Effects.TAX]) + "%"
	nobility_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.NOBILITY][GlobalData.Effects.LITERACY])
	nobility_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.NOBILITY][GlobalData.Effects.POLICING])
	nobility_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.NOBILITY][GlobalData.Effects.LABOR])
	nobility_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.NOBILITY][GlobalData.Effects.HEALTHCARE])
##

func update_clergy_display():
	clergy_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.CLERGY][GlobalData.Effects.TAX]) + "%"
	clergy_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.CLERGY][GlobalData.Effects.LITERACY])
	clergy_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.CLERGY][GlobalData.Effects.POLICING])
	clergy_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.CLERGY][GlobalData.Effects.LABOR])
	clergy_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % internal_stats_rep[GlobalData.Faction.CLERGY][GlobalData.Effects.HEALTHCARE])
##
