extends Node2D


@export var size: Vector2i
@export var cell_size: float
@export var cell_scene: PackedScene


var cells = {}


func _ready():
	initialize_cells()


func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var hovered_cell = get_hovered_cell()
		if hovered_cell:
			hovered_cell.set_alive(true)


func initialize_cells():
	for column in range(size.x):
		for row in range(size.y):
			var new_cell = cell_scene.instantiate()
			add_child(new_cell)
			new_cell.position = Vector2(float(column), float(row)) * cell_size
			cells[Vector2i(column, row)] = new_cell
			new_cell.set_alive(false)


func number_of_living_neighbors(pos):
	var result = 0
	for neighbor in get_neighbors(pos):
		if neighbor.is_alive:
			result += 1
	return result


func get_neighbors(pos):
	var lower_x = pos.x - 1 if pos.x > 0 else size.x - 1
	var lower_y = pos.y - 1 if pos.y > 0 else size.y - 1
	var upper_x = pos.x + 1 if pos.x < size.x - 1 else 0
	var upper_y = pos.y + 1 if pos.y < size.y - 1 else 0
	
	var v1 = Vector2i(lower_x, pos.y)
	var v2 = Vector2i(upper_x, pos.y)
	var v3 = Vector2i(pos.x, lower_y)
	var v4 = Vector2i(pos.x, upper_y)
	var v5 = Vector2i(lower_x, lower_y)
	var v6 = Vector2i(lower_x, upper_y)
	var v7 = Vector2i(upper_x, lower_y)
	var v8 = Vector2i(upper_x, upper_y)
	
	var neighbors = [
		cells[v1],
		cells[v2],
		cells[v3],
		cells[v4],
		cells[v5],
		cells[v6],
		cells[v7],
		cells[v8]
	]
	
	return neighbors


func get_hovered_cell():
	var mouse_pos = get_viewport().get_mouse_position()
	var cell_pos = Vector2i(mouse_pos / cell_size)
	if cells.has(cell_pos):
		return cells[cell_pos]
	else:
		return null


func get_next_cell_state(pos):
	var n = number_of_living_neighbors(pos)
	var cell = cells[pos]
	if cell.is_alive:
		return n == 2 or n == 3
	else:
		return n == 3


func tick():
	var next_states = {}
	for pos in cells.keys():
		next_states[pos] = get_next_cell_state(pos)
	for pos in cells.keys():
		cells[pos].set_alive(next_states[pos])
