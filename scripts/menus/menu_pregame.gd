extends Control

signal pregame_to_game
signal pregame_to_main

@onready var pregame_sheet = $Pregame

func _on_tutorial_button_pressed():
	pregame_to_game.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_back_button_pressed():
	pregame_to_main.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_decrease_button_pressed():
	if pregame_sheet.frame != 0:
		pregame_sheet.frame -=1
	elif pregame_sheet.frame == 0:
		pregame_sheet.frame = 7
	SoundManager.play_varied("ui", "Pressed", randf_range(0.6, 1))
##

func _on_increase_button_pressed():
	if pregame_sheet.frame != 7:
		pregame_sheet.frame +=1
	elif pregame_sheet.frame == 7:
		pregame_sheet.frame = 0
	SoundManager.play_varied("ui", "Pressed", randf_range(1, 1.4))
##

func _on_skip_button_pressed():
	pregame_sheet.frame = 7
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))

func _on_mouse_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##
