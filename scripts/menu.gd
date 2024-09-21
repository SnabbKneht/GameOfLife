extends Control


@onready var config = preload("res://config.tres")


@onready var title_screen = $TitleScreen
@onready var controls_screen = $ControlsScreen
@onready var settings_screen = $SettingsScreen


@onready var tick_slider = $SettingsScreen/CenterContainer/VBoxContainer/TickSlider
@onready var tick_value_label = $SettingsScreen/CenterContainer/VBoxContainer/TickValueLabel


func _ready():
	show_title()


func show_controls():
	title_screen.hide()
	settings_screen.hide()
	controls_screen.show()


func show_title():
	controls_screen.hide()
	settings_screen.hide()
	title_screen.show()


func show_settings():
	title_screen.hide()
	controls_screen.hide()
	tick_slider.value = config.tick_duration
	settings_screen.show()


func _on_play_button_pressed():
	SceneLoader.load_scene(SceneLoader.main_scene)


func _on_controls_button_pressed():
	show_controls()


func _on_settings_button_pressed():
	show_settings()


func _on_back_button_pressed():
	show_title()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_tick_slider_value_changed(value):
	tick_value_label.text = str(value) + "s"
	config.tick_duration = value
