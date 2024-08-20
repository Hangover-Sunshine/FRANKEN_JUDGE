extends Control

signal settings_to_main

func _on_back_button_pressed():
	settings_to_main.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_mouse_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##
