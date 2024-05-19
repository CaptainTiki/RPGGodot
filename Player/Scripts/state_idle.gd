class_name State_Idle extends State

@onready var walk = $"../Walk"

	
## What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("idle")

## What happens when the player leaves this state
func Exit() -> void:
	pass

## What happens with input events in this State
func Process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null

## What happens during the _physics_process update in this State
func Physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func HandleInput(_event : InputEvent) -> State:
	return null

