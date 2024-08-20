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
	gameover = PlayerPrefs.game_end
	show_text()
##

# shows what the player will see when game ends
func show_text():
	if gameover == 0:
		header.text = "SUCCESS"
		ap.play("Win")
		SoundManager.play("game_over", "good")
	elif gameover == 1:
		header.text = "FAILURE - PEASANTRY"
		ap.play("Peasantry")
		SoundManager.play("game_over", "mob")
	elif gameover == 2:
		header.text = "FAILURE - NOBILITY"
		ap.play("Nobility")
		SoundManager.play("game_over", "beheaded")
	elif gameover == 3:
		header.text = "FAILURE - CLERGY"
		ap.play("Clergy")
		SoundManager.play("game_over", "god")
	##
##

# goes to different scenes
func _on_again_button_pressed():
	Verho.change_scene("scenes/game_scene", "", "BlackFade")
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_leave_button_pressed():
	# new_scene:String, library:String, transition:String,
	Verho.change_scene("scenes/menus/hub_menu", "", "BlackFade")
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_mouse_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##
