class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export_category("Item Drops")
@export var drops: Array [DropData]

var _direction : Vector2
# var _animation_finished : bool = false
var _damage_position : Vector2 = Vector2.ZERO

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)

func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()
	drop_items()
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
	#this is important for things like boids that may not have a hurtbox
	# get our hurbox - or return null, if there is none
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	#if there is a hurtbox, turn it off - while we're destroying
	if hurt_box:
		hurt_box.monitoring = false

func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue #skip this empty one
		
		#not null, we have an item to drop
		var drop_count : int = drops[i].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			
			drop.item_data = drops[i].item
			#can't instantiate an area when an area triggers the instantiate
			#call_deffered waits until its safe, then calls the function
			enemy.get_parent().call_deferred("add_child", drop)
			#do the drop - 
			#needs to have a animation for the drop at the end, instead of a static vector
			#also - needs to check to bounce off walls / collisions
			drop.global_position = enemy.global_position
			#1.5 radians is about 85 degrees
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)

