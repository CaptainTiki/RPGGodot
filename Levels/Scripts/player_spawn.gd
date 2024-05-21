extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false #set to false so you can't see this during run time
	if PlayerManager.player_spawned == false:
		PlayerManager.set_player_position(global_position)
		
