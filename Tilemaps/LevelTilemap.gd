class_name LevelTilemap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.ChangeTilemapBounds(GetTilemapBounds())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(Vector2(get_used_rect().position * rendering_quadrant_size))  #top left of the tilemap
	bounds.append(Vector2(get_used_rect().end * rendering_quadrant_size))       #bottom right of the tilemap
	return bounds
