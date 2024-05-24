class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _direction : Vector2
var _animation_finished : bool = false
var _damage_position : Vector2 = Vector2.ZERO

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)

func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()
	pass

func exit() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func physics(_delta) -> EnemyState:
	return null

func _on_enemy_destroyed(hurt_box : HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)

func _on_animation_finished(_a : String) -> void:
	enemy.queue_free()

func disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
