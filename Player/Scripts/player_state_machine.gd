class_name PlayerStateMachine extends Node


var states : Array[ State ]
var prev_state : State
var current_state : State


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED  ##this prevents errors before initialize is called
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ChangeState(current_state.Process(delta))

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	ChangeState(current_state.Process(delta))

## if an event is unhandled (like an error) we pass that to our change state handler
func _unhandled_input(event):
	ChangeState(current_state.HandleInput(event))

func Initialize(_player : Player) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() > 0:
		states[0].player = _player
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState(new_state : State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()