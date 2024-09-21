extends Node


@onready var config = preload("res://config.tres")


@onready var grid = $Grid
@onready var timer = $Timer


func _ready():
	timer.set_wait_time(config.tick_duration)


func _input(event):
	if event.is_action_pressed("pause"):
		if timer.is_stopped():
			timer.start()
		else:
			timer.stop()
	
	if event.is_action_pressed("back"):
		SceneLoader.load_scene(SceneLoader.menu_scene)


func _on_timer_timeout():
	grid.tick()
