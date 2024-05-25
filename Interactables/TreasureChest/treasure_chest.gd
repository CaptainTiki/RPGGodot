@tool
class_name TreasureChest extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity


var is_open : bool = false

@onready var sprite: Sprite2D = $itemSprite
@onready var label: Label = $itemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $InteractArea


func _ready() -> void:
	#in editor stuff here
	_update_texture()
	_update_label()
	
	if Engine.is_editor_hint():
		return
	#ingame stuff here
	interact_area.area_entered.connect(on_area_enter)
	interact_area.area_exited.connect(on_area_exit)
	pass

func player_interact() -> void:
	if is_open == true:
		return #if the chest is already open - just return
	
	is_open = true #if it wasn't open - open it now
	animation_player.play("open_chest")
	if item_data and quantity > 0:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No Items in Chest!")
		push_error("No Items in Chest! Chest Name: ", name)
	
	pass

func on_area_enter(a : Area2D) -> void:
	#when the player enters the area - we need to start listening for the interaction input
	PlayerManager.interact_pressed.connect(player_interact)
	pass

func on_area_exit(a : Area2D) -> void:
	#when the player leaves this area - stop listening to the interaction input
	PlayerManager.interact_pressed.disconnect(player_interact)
	pass

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass

func _set_quantity(value : int) -> void:
	quantity = value
	_update_label()
	pass

func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
	pass

func _update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)
