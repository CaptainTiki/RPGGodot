class_name State extends Node

## Stores a reference to the player that this state belongs to
static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

## What happens when the player enters this state
func Enter() -> void:
	pass

## What happens when the player leaves this state
func Exit() -> void:
	pass

## What happens with input events in this State
func Process(_delta : float) -> State:
	return null

## What happens during the _physics_process update in this State
func Physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func HandleInput(_event : InputEvent) -> State:
	return null

