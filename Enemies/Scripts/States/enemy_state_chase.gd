class_name EnemyStateChase extends EnemyState

@export var anim_name : String = "chase"
@export var chase_speed: float = 20.0
@export var turn_rate : float = 0.25
@export_category("AI")
@export var vision_area : VisionArea
@export var attack_area : HurtBox
@export var state_aggro_duration : float = 0.5
@export var aggro_duration_variance : float = 0.5
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(_on_player_aggro)
		vision_area.player_exited.connect(_on_player_deaggro)

func enter() -> void:
	_set_aggro_timer()
	if attack_area:
		attack_area.monitoring = true
	enemy.update_animation(anim_name)
	pass

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
		
	_can_see_player = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta) -> EnemyState:
	var new_dir : Vector2 = enemy.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, new_dir, turn_rate) #lerp sets our direction to the new dir, overtime by the weight
	enemy.velocity = _direction * chase_speed
	if (enemy.set_direction(_direction)): #if our direction changes
		enemy.update_animation(anim_name)
	
	if _can_see_player == false:
		_timer -= _delta
		if _timer <= 0:
			return next_state
	else:
		_set_aggro_timer()
	return null

func physics(_delta) -> EnemyState:
	return null


func _on_player_aggro() -> void:
	_can_see_player = true
	
	#if we're stunned, don't chase
	if (
		state_machine.current_state is EnemyStateStun
		or state_machine.current_state is EnemyStateDestroy
		): 
		return
		
	state_machine.change_state(self)
	pass

func _on_player_deaggro() -> void:
	_can_see_player = false
	pass

func _set_aggro_timer() -> void:
	#sets the timer to the selected aggro_duration_variance
	#this way they don't all give up at the exact same time
	_timer = randf_range(state_aggro_duration - aggro_duration_variance, state_aggro_duration + aggro_duration_variance)
	pass
