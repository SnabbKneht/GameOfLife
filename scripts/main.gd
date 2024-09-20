extends Node


@onready var grid = $Grid
@onready var timer = $Timer


func _input(event):
	if event.is_action_pressed("pause"):
		print(timer.time_left)
		if timer.is_stopped():
			timer.start()
			print('starting timer')
		else:
			timer.stop()
			print('stopping timer')


func _on_timer_timeout():
	grid.tick()
