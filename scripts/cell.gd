extends Sprite2D


var is_alive = false


func set_alive(p_is_alive):
	is_alive = p_is_alive
	if is_alive:
		show()
	else:
		hide()
