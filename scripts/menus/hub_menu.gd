extends Node2D

@onready var menu_disclaimer = $MenuDisclaimer
@onready var menu_splash = $MenuSplash
@onready var menu_main = $MenuMain
@onready var menu_pregame = $MenuPregame
@onready var menu_settings = $MenuSettings
@onready var animplayer = $HubMenu_AnimPlayer
@onready var menu_timer = $MenuTimer

# manages the amount of seconds it takes to flip off of the specific menu page #
@export var time_disclaim = 4
@export var time_splash = 2

@onready var ready_to_click = false

# called when the node enters the scene tree for the first time. #
func _ready():
	if PlayerPrefs.was_disclaimed == false:
		animplayer.play("ToDisclaimer")
		menu_timer.wait_time = time_disclaim
		menu_timer.start()
	else:
		if MusicManager.is_playing("ost", "music") == false:
			MusicManager.play("ost", "music")
		else:
			MusicManager.set_volume(linear_to_db(1))
		##
		animplayer.play("ToSplash")
		menu_timer.wait_time = time_splash
		menu_timer.start()
	
	handle_signals()

# manages page flipping for any button press. Keeps MenuTimer in mind to delay instant flipping #
func _input(event):
	if event.is_pressed() and menu_splash.visible == true and menu_disclaimer.visible == false and ready_to_click == true:
		SoundManager.play("ui", "gavel_smack")
		to_main()
		ready_to_click = false
	elif event.is_pressed() and menu_splash.visible == false and menu_disclaimer.visible == true and ready_to_click == true:
		to_splash()
		menu_timer.wait_time = time_splash
		menu_timer.start()
		ready_to_click = false
	##
##

func handle_signals():
	menu_disclaimer.was_disclaimed.connect(disclaimed)
	menu_main.main_to_pregame.connect(to_pregame)
	menu_main.main_to_settings.connect(to_settings)
	menu_main.main_to_exit.connect(to_exit)
	menu_pregame.pregame_to_main.connect(to_main)
	menu_pregame.pregame_to_game.connect(to_load)
	menu_settings.settings_to_main.connect(to_main)
	Verho.connect("loaded_scene", to_free)

func disclaimed():
	PlayerPrefs.was_disclaimed = true

func to_splash():
	MusicManager.play("ost", "music")
	animplayer.play("ToSplash")

func to_main():
	animplayer.play("ToMain")

func to_pregame():
	animplayer.play("ToPregame")

func to_settings():
	animplayer.play("ToSettings")

func to_exit():
	get_tree().quit()

func to_load():
	Verho.change_scene("scenes/game_scene", "", "BlackFade")

func to_free(scene_name):
	if scene_name != name:
		self.queue_free()
	##
##

func _on_menu_timer_timeout():
	ready_to_click = true
