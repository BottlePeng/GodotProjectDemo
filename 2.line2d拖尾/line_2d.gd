extends Line2D

var timer:float = 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= 0.01:
		add_point(to_local(get_global_mouse_position()))
		timer = 0
		if get_point_count() >= 20:
			remove_point(0)
