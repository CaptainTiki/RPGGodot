class_name PersistantDataHandler extends Node

signal data_loaded
var value: bool = false

func _ready() -> void:
	#print(_get_name())   #this prints out the persistant data - so you can check load functions
	get_value()
	pass

func set_value() -> void:
	SaveManager.add_persistant_value(_get_name())
	pass

func get_value() -> void:
	value = SaveManager.check_persistant_value(_get_name())
	data_loaded.emit()
	pass

func _get_name() -> String:
	#"res://levels/AreaName/LevelName.tscn/ITEMNAME/PersistantDataHandler"
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
