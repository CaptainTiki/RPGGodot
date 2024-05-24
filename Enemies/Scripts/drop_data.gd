class_name DropData extends Resource

@export var item : ItemData
@export_range(0,100,1,"suffix:%") var probability : float = 100
@export_range(1,10,1,"suffix:items") var min_ammount : int = 1
@export_range(1,10,1,"suffix:items") var max_ammount : int = 1

func get_drop_count() -> int:
	if randf_range(0,100)>= probability:
		return 0 # outside probability range, dont drop
		
	return randi_range(min_ammount, max_ammount)
