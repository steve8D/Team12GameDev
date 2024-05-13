extends Control

# The inventory Slots store the scripts of the item, see lookUpItemType()
@onready var inventorySlots = {1: null, 2: null, 3: null, 4: null}
var consuming_slot = 0		
signal itemPickedUp(item)
signal itemConsumed(item)

func _process(delta):
	if Input.is_action_just_pressed("use_slot1"):
		if inventorySlots[1] != null:
			consuming_slot = 1
			itemConsumed.emit(inventorySlots[1])
	elif Input.is_action_just_pressed("use_slot2"):
		if inventorySlots[2] != null:
			consuming_slot = 2
			itemConsumed.emit(inventorySlots[2])
	elif Input.is_action_just_pressed("use_slot3"):
		if inventorySlots[3] != null:
			consuming_slot = 3
			itemConsumed.emit(inventorySlots[3])
	elif Input.is_action_just_pressed("use_slot4"):
		if inventorySlots[4] != null:
			consuming_slot = 4
			itemConsumed.emit(inventorySlots[4])		

func isInventoryFull():
	for i in inventorySlots:
		if inventorySlots[i] == null:
			return i
	return 0

func lookUpItemType(itemName):
	var info
	# this function will grow as we add more item, consider adding a class to handle this
	if itemName == "Mana Potion":
		info = load("res://scripts/gameplay/ManaPotion.gd")
	return info
		
func addItemToInventory(slot, item):
	inventorySlots[slot] = item
	var slotPath = "Slot%s/InventoryIcon" % slot
	var icon = get_node(slotPath)
	icon.visible = true
	icon.texture = load(item.itemIconPath)

func _on_item_item_picked_up(itemName):
	var availableSlot = isInventoryFull()
	if availableSlot != 0:
		var item = lookUpItemType(itemName)
		addItemToInventory(availableSlot, item)


func _on_player_player_stamina_increased():
	inventorySlots[consuming_slot] = null
	var slotPath = "Slot%s/InventoryIcon" %consuming_slot
	var icon = get_node(slotPath)
	icon.visible = false
