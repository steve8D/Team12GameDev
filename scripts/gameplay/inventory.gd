extends Control

@onready var inventorySlots = {1: null, 2: null, 3: null, 4: null}		

func addItemToIventory(slot):
	pass
	# inventorySlots[slot] = item

func isInventoryFull():
	for i in inventorySlots:
		if i == null:
			return i
	return false


func _on_item_item_picked_up(itemName):
	var availableSlot = isInventoryFull()
	if availableSlot != false:
		pass
		#addItemToIventory(availableSlot, item)
