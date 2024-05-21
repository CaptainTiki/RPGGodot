class_name State extends Node

## Stores a reference to the player that this state belongs to
static var player: Player
static var state_machine : PlayerStateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init() -> void:
	pass

## What happens when the player enters this state
func enter() -> void:
	pass

## What happens when the player leaves this state
func exit() -> void:
	pass

## What happens with input events in this State
func process(_delta : float) -> State:
	return null

## What happens during the _physics_process update in this State
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func handle_input(_event : InputEvent) -> State:
	return null

