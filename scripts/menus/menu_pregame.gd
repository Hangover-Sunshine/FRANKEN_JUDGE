extends Control

signal pregame_to_game
signal pregame_to_main

@onready var pregame_sheet = $Pregame

func _on_tutorial_button_pressed():
	pregame_to_game.emit()

func _on_back_button_pressed():
	pregame_to_main.emit()

func _on_decrease_button_pressed():
	if pregame_sheet.frame != 0:
		pregame_sheet.frame -=1
	elif pregame_sheet.frame == 0:
		pregame_sheet.frame = 6

func _on_increase_button_pressed():
	if pregame_sheet.frame != 6:
		pregame_sheet.frame +=1
	elif pregame_sheet.frame == 6:
		pregame_sheet.frame = 0

func _on_skip_button_pressed():
	pregame_sheet.frame = 6
