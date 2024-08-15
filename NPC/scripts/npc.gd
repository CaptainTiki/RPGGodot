@tool
@icon("res://NPC/icons/npc.svg")
class_name NPC extends CharacterBody2D

signal do_behavior_enabled

var state: String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"

@export var npc_resource : NPCResource

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	setup_npc()
	if Engine.is_editor_hint():
		return 
	pass

func setup_npc() -> void:
	if npc_resource:
		sprite.texture = npc_resource.sprite
