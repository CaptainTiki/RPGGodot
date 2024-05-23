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



