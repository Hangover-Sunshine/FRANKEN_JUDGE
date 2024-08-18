extends Control

signal done_loading_society

func load_data(group:GlobalData.Faction, argument:String, effects:Array[BaseEffectResource]):
	$WinningMegaCard.show_labels(group, argument, effects)
##

func play_animations():
	# TODO: replace with anims
	pass
##
