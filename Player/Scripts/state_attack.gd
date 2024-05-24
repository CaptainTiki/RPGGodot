class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1,10,0.5) var decel_speed : float = 3.0

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animPlayer : AnimationPlayer = $"../../PlayerSprite/AttackEffectSprite/AnimationPlayer"
@onready var audio_player : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box = %AttackHurtBox


	
## What happens when the player enters this state
func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(endAttack)
	attack_animPlayer.play("attack_" + player.anim_direction())
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
	attacking = true
	
	await get_tree().create_timer(0.075).timeout #timer to wait until attack is most way through swing
	
	if attacking: #keeps the player hurtbox from staying on during the await functions
		hurt_box.monitoring = true

## What happens when the player leaves this state
func exit() -> void:
	animation_player.animation_finished.disconnect(endAttack)
	attacking = false
	hurt_box.monitoring = false
	pass

## What happens with input events in this State
func process(_delta : float) -> State:	
	player.velocity -= player.velocity * decel_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null

## What happens during the _physics_process update in this State
func physics(_delta : float) -> State:
	return null

## What happens with input events in this State
func handle_input(_event : InputEvent) -> State:
	return null

func endAttack(_animName : String) -> void:
	attacking = false

