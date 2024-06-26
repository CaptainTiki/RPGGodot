class_name InventoryData extends Resource

@export var slots : Array[SlotData]

func _init() -> void:
	connect_slots()


func add_item(item: ItemData, count : int = 1) -> bool:
	for s in slots:
		if s: #is there anything in the slot - returns true if so
			if s.item_data == item:  #if the item we picked up - is the same itme
				s.quantity += count #add it to our count
				print("added to existing slot")
				return true #tell them we picked the item up
	
	for i in slots.size():
		if slots[i] == null: #our slot is empty, so we can add it
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			new.changed.connect(slot_changed)
			print("added to new slot")
			return true
			
	print("unable to add inv item")
	return false #if we dont have room to pick up
	

func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)


func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
pass

## Gather the inventory into an array
func get_save_data() -> Array:
	var item_save : Array = []
	for i in slots.size():
		item_save.append(item_to_save(slots[i]))
	return item_save

## Convert each inventory item into a dictionary
func item_to_save(slot : SlotData ) -> Dictionary:
	var result = {item = "", quantity = 0}
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result


## convert dictionary back to inventory
func parse_save_data(save_data : Array ) -> void:
	var array_size = slots.size() #create our inventory array
	slots.clear() #clear it out so its null
	slots.resize(array_size) #resize and fill with empty slot data (null slots)
	for i in save_data.size():
		slots[i] = item_from_save(save_data[i]) #foreach item in the save data - fill the inventory slot with that item
	
	connect_slots() #reconnect the slots to the inventory
	pass

## convert dictionary to slot data
func item_from_save(save_object : Dictionary) -> SlotData:
	if save_object.item == "":
		return null
		
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot

func use_item( item : ItemData, count : int = 1 ) -> bool:
	for s in slots:
		if s:
			if s.item_data == item and s.quantity >= count:
				#we should have the right item and the required quantity
				s.quantity -= count
				return true
	
	#we either don't have the item, or dont have enough
	return false

