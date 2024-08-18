extends Control

@onready var peasant_stat_labels = [
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Tax_Hbox/Peasant_Tax,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lit_Hbox/Peasant_Lit,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Pol_Hbox/Peasant_Pol,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Lab_Hbox/Peasant_Lab_Rank,
	$Society_Vbox/Society_Hbox/Peasantry/Society_Peasant_Ranks_Hbox/Vbox_Peasantry/Peasant_Hea_Hbox/Peasant_Hea_Rank
]

@onready var nobility_stat_labels = [
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Tax_Hbox/Nobility_Tax,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lit_Hbox/Nobility_Lit,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Pol_Hbox/Nobility_Pol,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Lab_Hbox/Nobility_Lab_Rank,
	$Society_Vbox/Society_Hbox/Nobility/Society_Nobility_Ranks_Hbox/Vbox_Nobility/Nobility_Hea_Hbox/Nobility_Hea_Rank
]

@onready var clergy_stat_labels = [
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Tax_Hbox/Clergy_Tax,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lit_Hbox/Clergy_Lit,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Pol_Hbox/Clergy_Pol,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Lab_Hbox/Clergy_Lab_Rank,
	$Society_Vbox/Society_Hbox/Clergy/Society_Clergy_Ranks_Hbox/Vbox_Clergy/Clergy_Hea_Hbox/Clergy_Hea_Rank
]

func _ready():
	pass
##

func load_peasant_stats(pstats):
	peasant_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % pstats[GlobalData.Effects.TAX]) + "%"
	peasant_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.LITERACY])
	peasant_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.POLICING])
	peasant_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.LABOR])
	peasant_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % pstats[GlobalData.Effects.HEALTHCARE])
##

func load_nobility_stats(nstats):
	nobility_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % nstats[GlobalData.Effects.TAX]) + "%"
	nobility_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.LITERACY])
	nobility_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.POLICING])
	nobility_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.LABOR])
	nobility_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % nstats[GlobalData.Effects.HEALTHCARE])
##

func load_clergy_stats(cstats):
	clergy_stat_labels[0].text = (GlobalData.THREE_NUM_DISPLAY % cstats[GlobalData.Effects.TAX]) + "%"
	clergy_stat_labels[1].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.LITERACY])
	clergy_stat_labels[2].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.POLICING])
	clergy_stat_labels[3].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.LABOR])
	clergy_stat_labels[4].text = (GlobalData.TWO_NUM_DISPLAY % cstats[GlobalData.Effects.HEALTHCARE])
##
