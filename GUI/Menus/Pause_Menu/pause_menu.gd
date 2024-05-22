extends CanvasLayer

signal shown
signal hidden

@onready var bn_save = $Control/HBoxContainer/bn_Save
@onready var bn_load = $Control/HBoxContainer/bn_Load
@onready var lbl_item_description: Label = $Control/lbl_itemDescription

var is_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_pause_menu()
	bn_save.pressed.connect(_on_save_pressed)
	bn_load.pressed.connect(_on_load_pressed)
	pass # Replace with function body.

func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
			pass
		else:
			hide_pause_menu()
			pass
	get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	shown.emit()
	pass

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()
	pass

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	pass

func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	pass

func update_item_description(new_text : String) -> void:
	lbl_item_description.text = new_text
