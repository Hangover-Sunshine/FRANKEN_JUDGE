extends Control

signal pause_to_game
signal pause_to_settings
signal pause_to_main

func _on_cont_button_pressed():
	pause_to_game.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))

func _on_settings_button_pressed():
	pause_to_settings.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))

func _on_leave_button_pressed():
	pause_to_main.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))

func _on_mouse_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##
