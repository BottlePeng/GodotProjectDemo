extends TextureRect
class_name GridClass

func point_detect(poi:Vector2) ->bool:
	if Rect2(global_position,size).has_point(poi):
		return true
	else :
		return false
