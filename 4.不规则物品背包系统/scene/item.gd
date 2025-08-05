extends Node2D
class_name ItemClass

@onready var item_texture_rect: TextureRect = $MarginContainer/ItemTextureRect

const ITEM_ICON = preload("res://resources/item_icon.png")


var index:int
var size:Vector2 #尺寸
var offset:Vector2 #鼠标抓取偏移量

#region 测试物品
var shield: Dictionary = {
	&"id" : 1,
	&"icon_axis" : Rect2(16, 0, 32, 32),
	&"size" : Vector2(2,2)
}
var sword: Dictionary = {
	&"id" : 2,
	&"icon_axis" : Rect2(16, 32, 16, 32),
	&"size" : Vector2(1,2)
}
var potion: Dictionary = {
	&"id" : 3,
	&"icon_axis" : Rect2(32, 32, 16, 16),
	&"size" : Vector2(1,1)
}

var test_item: Dictionary = {
	1 : shield,
	2 : sword,
	3 : potion,
}
#endregion

func set_item(item_index:int) ->void:
	index = item_index
	if index ==0:
		hide()
	else :
		var item_dir = test_item[index]
		size = item_dir[&"size"]
		var new_texture:=AtlasTexture.new()
		new_texture.atlas = ITEM_ICON
		new_texture.region = item_dir[&"icon_axis"]
		item_texture_rect.texture = new_texture
		offset = -new_texture.region.size / 2
		show()
	

func update_position() -> void:
	global_position = get_global_mouse_position() + offset
