extends Control

signal done_loading_society

func load_data(group:GlobalData.Faction, argument:String, effects:Array[BaseEffectResource]):
	$WinningMegaCard.hide_all()
	$WinningMegaCard.show_labels(group, argument, effects)
##

func play_swoosh(min_pitch:float, max_pitch:float):
	SoundManager.play_varied("ui", "swoosh", randf_range(min_pitch, max_pitch))
##
