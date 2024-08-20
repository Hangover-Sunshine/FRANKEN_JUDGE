extends Control

signal settings_to_main

@onready var full_check = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/General_HBox/Display_VBox/Full_HBox/Full_Check

@onready var overall_slider = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/Overall_HBox/Overall_Slider
@onready var overall_percent = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/Overall_HBox/Overall_Percent

@onready var sfx_slider = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/SFX_HBox/SFX_Slider
@onready var sfx_percent = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/SFX_HBox/SFX_Percent

@onready var music_slider = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/Music_HBox/Music_Slider
@onready var music_percent = $Settings_MC/Settings_VBox/Tab_Vbox/Settings_Tab_Hbox/Audio_HBox/Audio_VBox/Music_HBox/Music_Percent

func _ready():
	sfx_slider.value = GlobalSettings.UiSFXVolume * 100
	sfx_percent.text = str(sfx_slider.value) + "%"
	music_slider.value = GlobalSettings.MusicVolume * 100
	music_percent.text = str(music_slider.value) + "%"
	overall_slider.value = GlobalSettings.MasterVolume * 100
	overall_percent.text = str(overall_slider.value) + "%"
	
	full_check.set_pressed_no_signal(GlobalSettings.FullScreen)
##

func _on_back_button_pressed():
	GlobalSettings.save_settings()
	settings_to_main.emit()
	SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
##

func _on_mouse_entered():
	SoundManager.play_varied("ui", "MouseOver", randf_range(0.7, 1.2))
##

func _on_full_check_toggled(toggled_on):
	GlobalSettings.FullScreen = toggled_on
	
	if SoundManager.has_loaded:
		SoundManager.play_varied("ui", "Pressed", randf_range(0.7, 1.2))
	##
	
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	##
##

func _on_overall_slider_value_changed(value):
	overall_percent.text = str(value) + "%"
	GlobalSettings.MasterVolume = value / 100
	var sfx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(sfx, linear_to_db(GlobalSettings.MasterVolume))
##

func _on_sfx_slider_value_changed(value):
	sfx_percent.text = str(value) + "%"
	GlobalSettings.UiSFXVolume = value / 100
	var sfx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx, linear_to_db(GlobalSettings.UiSFXVolume))
##

func _on_music_slider_value_changed(value):
	music_percent.text = str(value) + "%"
	GlobalSettings.MusicVolume = value / 100
	var sfx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(sfx, linear_to_db(GlobalSettings.MusicVolume))
##
