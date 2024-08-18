extends Control

@onready var reputation_rates_vbox = $Reputation_Vbox/Reputation_Hbox/Reputation_Rates_Vbox

@onready var bars = [
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Peasantry_Hbox/Peasantry_Rep_Bar,
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Nobility_Hbox/Nobility_Rep_Bar,
	$Reputation_Vbox/Reputation_Hbox/Reputation_Vbox/Rep_Clergy_Hbox/Clergy_Rep_Bar
]

func load_peasant_rep(rep):
	bars[0].value = rep
##

func load_nobility_rep(rep):
	bars[1].value = rep
##

func load_clergy_rep(rep):
	bars[2].value = rep
##
