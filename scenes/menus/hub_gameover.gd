extends Control

@onready var header = $MC_Gameover/Vbox_Gameover/Header
@onready var peasantry = $MC_Gameover/Vbox_Gameover/Vbox_Story/Vbox_Peasantry
@onready var nobility = $MC_Gameover/Vbox_Gameover/Vbox_Story/Vbox_Nobility
@onready var clergy = $MC_Gameover/Vbox_Gameover/Vbox_Story/Vbox_Clergy
@onready var win = $MC_Gameover/Vbox_Gameover/Vbox_Story/Vbox_Win
@onready var ap = $AP_Gameover

# 0 = win | 1 = peasantry game over | 2 = nobility game over | 3 = clergy game over
var gameover = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	show_text()

# shows what the player will see when game ends
func show_text():
	if gameover == 0:
		header.text = "SUCCESS"
		ap.play("Win")
	elif gameover == 1:
		header.text = "FAILURE"
		ap.play("Peasantry")
	elif gameover == 2:
		header.text = "FAILURE"
		ap.play("Nobility")
	elif gameover == 3:
		header.text = "FAILURE"
		ap.play("Clergy")

# goes to different scenes
func _on_again_button_pressed():
	pass # Replace with function body.

func _on_leave_button_pressed():
	pass # Replace with function body.
