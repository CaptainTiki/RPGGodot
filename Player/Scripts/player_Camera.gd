class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.TilemapBoundsChanged.connect(UpdateLimits) #connect to the event - to always update when it changes
	UpdateLimits(LevelManager.current_tilemap_bounds) #also force update the first time on load

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func UpdateLimits(bounds : Array[Vector2]) -> void:
	if bounds == []:
		return
		
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
