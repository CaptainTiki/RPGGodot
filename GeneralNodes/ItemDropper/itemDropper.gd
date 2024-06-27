@tool

class_name ItemDropper extends Node2D

const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")

var has_dropped : bool = false

@export var item_data : ItemData : set = _set_item_data
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer
@onready var has_dropped_data = $PersistantDataHandler


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint() == true:
		_update_texture()
		return
	
	sprite.visible = false
	has_dropped_data.data_loaded.connect(_on_data_loaded)
	_on_data_loaded()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()

func drop_item() -> void:
	if has_dropped == true:
		return
	
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.item_data = item_data
	add_child(drop)
	drop.pickedUp.connect(_on_drop_PickedUp)
	audio_player.play()

func _update_texture() -> void:
	if Engine.is_editor_hint():
		if item_data and sprite:
			sprite.texture = item_data.texture


func _on_drop_PickedUp() -> void:
	has_dropped_data.set_value()


func _on_data_loaded() -> void:
	has_dropped = has_dropped_data.value


func _on_enemy_counter_enemies_defeated():
	pass # Replace with function body.
