extends Control

signal main_to_pregame
signal main_to_settings
signal main_to_exit

func _ready():
	if GlobalSettings.os_type == "Web":
		$Main_MC/Main_VBox/Button_HBox/Button_VBox/Exit_Button.mouse_filter = MOUSE_FILTER_IGNORE
		$Main_MC/Main_VBox/Button_HBox/Button_VBox/Exit_Button.visible = false
	##
##

func _on_start_button_pressed():
	main_to_pregame.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_settings_button_pressed():
	main_to_settings.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_exit_button_pressed():
	main_to_exit.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_focus_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##
