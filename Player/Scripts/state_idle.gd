class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"

	
## What happens when the player enters this state
func enter() -> void:
	player.update_animation("idle")

## What happens when the player leaves this state
func exit() -> void:
	pass

## What happens with input events in this State
func process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null

## What happens during the _physics_process update in this State
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	else:
		return null

