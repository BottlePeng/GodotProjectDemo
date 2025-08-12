extends ColorRect

const CARD = preload("res://card.tscn")

var hand_count:int = 0

#region 动画控制
@export var hand_curve:Curve ##手牌高度曲线
@export var rotation_curve:Curve ##手牌旋转曲线

@export var max_rotation_degrees:int = 10 ##最大旋转角度
@export var max_sep:float = -10##最大间隔
@export var y_base:int = 50 ##基础高度
@export var y_max:int = -50 ##最大偏移高度
#endregion

var hovered_card_index:int = -1

func _ready() -> void:
	Events.card_hover_change.connect(_on_card_hover_change)

##发牌
func _deal(cards_count:int) -> void:
	for i in cards_count:
		var card = CARD.instantiate()
		add_child(card)
		card.global_position = $"../HandPile".global_position
	_update_cards()

##弃牌
func _fold(cards_count:int) -> void:
	var cards:Array = get_children()
	if !cards:
		return
	for i in cards_count:
		var tween = get_tree().create_tween()
		tween.tween_property(cards[cards.size()-1],"global_position",$"../DiscardPile".global_position,0.1)
		await tween.finished
		if cards[cards.size()-1]:
			cards[cards.size()-1].free()
	_update_cards()

##有卡牌悬停
func _on_card_hover_change(card_ui:Crad, is_hovered:bool) -> void:
	var cards = get_children()
	#确保正确的移入移出逻辑
	for card:Crad in cards:
		if card != card_ui and is_hovered:
			card.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else :
			card.mouse_filter = Control.MOUSE_FILTER_STOP
	#悬浮卡牌相对于hand节点的索引
	hovered_card_index = cards.find(card_ui) if is_hovered else -1
	_update_cards()
	
##更新卡牌位置
func _update_cards() -> void: 
	hand_count = get_child_count()
	if hand_count == 0:
		return
	var sep := (size.x - 100 * hand_count) / (hand_count - 1)
	if sep > max_sep:
		sep = max_sep
	#居中偏移量
	var offset := (size.x - 100 * hand_count - sep * (hand_count - 1)) / 2
	
	for i in hand_count:
		var card:Crad = get_child(i)
		var x:float
		var y:float
		var rot:float
		var card_scale:Vector2

		#只有一张卡牌时不进行偏转
		if hand_count == 1:
			y = y_base + y_max
			rot = 0.0
		
		if hovered_card_index == -1:
			x = offset + (100 + sep) * i
		else :
			var diff = i - hovered_card_index
			if diff < 5 or diff > -5:
				if diff != 0:
					x = offset + (100 + sep) * i + 30.0 / diff
				else:
					x = offset + (100 + sep) * i
			else :
				x = offset + (100 + sep) * i
		
		if i == hovered_card_index:
			y = y_max
			rot = 0
			card_scale = Vector2(1.5,1.5)
		else :
			y = y_base + y_max * hand_curve.sample((x+50) / size.x)
			rot = max_rotation_degrees * rotation_curve.sample((x+50) / size.x)
			card_scale = Vector2(1,1)

		var tween = get_tree().create_tween()
		tween.tween_property(card,"position",Vector2(x,y),0.1)
		tween.parallel().tween_property(card,"scale",card_scale,0.2)
		tween.parallel().tween_property(card,"rotation_degrees",rot,0.2)

func _on_button_pressed() -> void:
	_deal(1)

func _on_button_2_pressed() -> void:
	_fold(1)
