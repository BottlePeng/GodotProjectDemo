## 手牌类
class_name Crad extends Panel

func _on_mouse_entered() -> void:
	Events.card_hover_change.emit(self,true)
	z_index = 1

func _on_mouse_exited() -> void:
	Events.card_hover_change.emit(self,false)
	z_index = 0
