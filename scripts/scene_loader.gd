extends Node


var main_scene = preload("res://scenes/main.tscn")
var menu_scene = preload("res://scenes/menu.tscn")


var current_scene


func _ready():
	current_scene = get_tree().current_scene


func load_scene(scene):
	var new_scene = scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().root.remove_child(current_scene)
	current_scene.queue_free()
	current_scene = new_scene
