class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var player_sprite : Sprite2D = $PlayerSprite

signal DirectionChanged(new_direction:Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Initialize(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()


func _physics_process(_delta):
	move_and_slide()

func SetDirection() -> bool:
	if direction == Vector2.ZERO: ##if no input from user / char is idle
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
