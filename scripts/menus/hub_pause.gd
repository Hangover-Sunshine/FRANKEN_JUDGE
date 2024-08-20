extends Node2D

signal unpause_by_button

@onready var menu_pause = $MenuPause
@onready var menu_settings = $MenuSettings
@onready var animplayer = $HubPause_AnimPlayer

func _ready():
	handle_signals()

func handle_signals():
	menu_pause.pause_to_game.connect(to_game)
	menu_pause.pause_to_settings.connect(to_settings)
	menu_settings.settings_to_main.connect(to_pause)
	menu_pause.pause_to_main.connect(to_load)

func to_game():
	emit_signal("unpause_by_button")
##

func to_pause():
	animplayer.play("ToPause")

func to_settings():
	animplayer.play("ToSettings")

func to_load():
	Verho.change_scene("scenes/menus/hub_menu", "", "BlackFade")
	$MenuPause.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
	get_parent().visible = false
##
