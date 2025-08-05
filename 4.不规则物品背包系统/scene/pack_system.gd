extends Control

@onready var picked_item: ItemClass = $PickedItem

@onready var grid_mgr: GridContainer = $Pack/PanelContainer/GridMgr
#gridmgr的网格宽度
var grid_columns:int

const ITEM = preload("res://scene/item.tscn")

var picked_item_index:int = 0
var pack_inventory:Array[Array] = []
#储存二元数组[x,y],x为存储物品的ID,y为grid相对于 GridMgr的索引,没储存物品时数据位[]

func _ready() -> void:
	picked_item.hide()
	pack_inventory.resize(grid_mgr.get_child_count())
	grid_columns = grid_mgr.columns

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if picked_item_index:
		picked_item.update_position()

#拿起与放下物品逻辑
func _on_grid_mgr_gui_input(event: InputEvent) -> void:
	#鼠标点击事件
	if event is InputEventMouseButton and event.is_pressed():
		#有拿起物品时的逻辑
		if picked_item_index:
			_get_item()
		#没拿起物品时的逻辑
		else:
			_pick_item()

#交换或放下物体
func _get_item()->void:
	var rect_poi:Array[Vector2]
	for x in picked_item.size.x:
		for y in picked_item.size.y:
			var ax:float = picked_item.global_position.x + x * 16
			var ay:float = picked_item.global_position.y + y * 16
			var detect_rect:=Rect2(ax,ay,16,16)
			rect_poi.append(detect_rect.get_center())
	for poi in rect_poi:
		if !Rect2(grid_mgr.global_position,grid_mgr.size).has_point(poi):
			return#不在范围内,无事发生
	for grid_count in grid_mgr.get_child_count():
		if grid_mgr.get_child(grid_count).point_detect(rect_poi[0]):
			#需要检测的格子
			var grid_d:Array
			for y in picked_item.size.y:
				for x in picked_item.size.x:
					var index = grid_count + x + y * grid_columns
					if index+1 > grid_mgr.get_child_count():
						#格子索引超出范围
						return
					grid_d.append(index) 
			match _grid_detect(grid_d):
				-1:
					#放下物品
					_put_item(grid_count)
					_set_picked_item(0)
				-2:
					#无事发生
					pass
				var index:
					#交换物品
					#清除显示
					grid_mgr.get_child(pack_inventory[index][1]).get_child(0).free()
					#清除数据
					var data = pack_inventory[index]
					for i in pack_inventory.size():
						if pack_inventory[i] == data:
							pack_inventory[i] = []
					#放下物品
					_put_item(grid_count)
					#更改PickedItem
					_set_picked_item(data[0])
func _put_item(grid_count:int)->void:
	var item = ITEM.instantiate()
	grid_mgr.get_child(grid_count).add_child(item)
	item.set_item(picked_item_index)
	for x in picked_item.size.x:
		for y in picked_item.size.y:
			pack_inventory[grid_count + x + y*grid_mgr.columns] = [picked_item_index,grid_count]
#拿起物品
func _pick_item()->void:
	var poi = get_global_mouse_position()
	for grid_count in grid_mgr.get_child_count():
		if grid_mgr.get_child(grid_count).point_detect(poi) and pack_inventory[grid_count]:
			#清除显示
			grid_mgr.get_child(pack_inventory[grid_count][1]).get_child(0).free()
			#清除数据
			var data = pack_inventory[grid_count]
			for i in pack_inventory.size():
				if pack_inventory[i] == data:
					pack_inventory[i] = []
			#更改PickedItem
			picked_item.set_item(data[0])
			picked_item_index = data[0]
			picked_item.show()

#所占格子检测,都是空格子返回-1,多个物品占着格子返回-2,有某一个物品占着格子返回所占第一个格子的索引
func _grid_detect(grid_index:Array)->int:
	for index in grid_index:
		#空grid的数据位[],有占用时为[x,y]
		if pack_inventory[index]:
			for index_2 in grid_index:
				if pack_inventory[index_2]:
					if pack_inventory[index_2][1] != pack_inventory[index][1]:
						return -2
			return index
	return -1

#生成物品并拿起
func _on_button_pressed() -> void:
	var index = picked_item_index+1 if picked_item_index < 3 else 1
	_set_picked_item(index)

#销毁拿起的物品
func _on_button_2_pressed() -> void:
	_set_picked_item(0)

#设置PickedItem
func _set_picked_item(index:int) ->void:
	picked_item_index = index
	picked_item.set_item(index)
