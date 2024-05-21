class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var move_speed : float = 100.0
@export_group("Change Stun Animation to match")
@export var invulnerable_duration : float = 1.0

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

@onready var idle : State = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_player_damaged)

## What happens when the player enters this state
func enter() -> void:
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	
	player.update_animation("stun")
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	pass

## What happens when the player leaves this state
func exit() -> void:
	next_state = null #set the next state to null, so that if we get damaged again we don't skip the damaged state
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass

## What happens with input events in this State
func process(delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * delta
	return next_state #move to the next state if its not null

## What happens during the _physics_process update in this State
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func handle_input(_event : InputEvent) -> State:
	return 

func _player_damaged(_hurt_box:HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.change_state(self)
	pass

func _animation_finished(_a: String)->void:
	next_state = idle #set the state to move to once the animation finished
