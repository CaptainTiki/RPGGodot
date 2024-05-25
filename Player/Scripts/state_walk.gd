class_name State_Walk extends State

@export var move_speed : float = 100.0
@export var run_speed : float = 150.0
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"

## What happens when the player enters this state
func enter() -> void:
	player.update_animation("walk")

## What happens when the player leaves this state
func exit() -> void:
	pass

## What happens with input events in this State
func process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	if Input.is_action_pressed("sprint"):
		player.velocity = player.direction * run_speed
	else:
		player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	return null

## What happens during the _physics_process update in this State
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	
	return null
