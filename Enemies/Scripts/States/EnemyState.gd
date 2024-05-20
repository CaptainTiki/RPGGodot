class_name EnemyState extends Node

## Stores Reference to the enemy it belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine


func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	pass

func exit() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta) -> EnemyState:
	return null

func physics(_delta) -> EnemyState:
	return null
