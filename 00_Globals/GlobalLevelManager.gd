extends Node

signal level_load_started()
signal level_load_finished()
signal TilemapBoundsChanged(bounds: Array[Vector2])

var current_tilemap_bounds : Array[Vector2]
var target_transition : String
var position_offset : Vector2

func _ready() -> void:
	await get_tree().process_frame
	level_load_finished.emit()

func ChangeTilemapBounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TilemapBoundsChanged.emit(bounds)

func load_new_level(level_path : String, _target_transition : String, _position_offset : Vector2) -> void:
	get_tree().paused = true #pause the game while we transition
	position_offset = _position_offset
	target_transition = _target_transition
	await get_tree().process_frame #level transition - fade out
	level_load_started.emit()
	
	#make sure that the prev level is removed- before we load the new one
	await get_tree().process_frame
	get_tree().change_scene_to_file(level_path)
	
	await get_tree().process_frame #level transition - fade in
	get_tree().paused = false
	
	#make sure we have the new level loaded before we broadcast the finished
	await get_tree().process_frame
	level_load_finished.emit()
	pass
