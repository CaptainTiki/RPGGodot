class_name ItemData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D


@export_category("Item Use Effects")
@export var effects : Array[ItemEffect]

func use() -> bool:
	#if we don't have any effects, return false
	if effects.size() == 0:
		return false
	#if we have an effect, lets process that
	for e in effects:
		if e: #make sure its not an empty item
			e.use()
			
	#return that we've used the item
	return true

