extends Control

signal done_loading_society

func load_data(group:GlobalData.Faction, argument:String, effects:Array[BaseEffectResource]):
	$WinningMegaCard.hide_all()
	$WinningMegaCard.show_labels(group, argument, effects)
##
