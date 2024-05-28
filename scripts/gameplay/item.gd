class_name item extends Area2D

signal itemPickedUp(itemName)

@export var itemName = ""
var itemIsInRange = false

func _process(delta):
	if Input.is_action_pressed("pick_up_item") and itemIsInRange and is_visible():
		itemPickedUp.emit(itemName)
		# handle what happens when inventory is full in the future
		hide()

func _on_body_entered(body):
	itemIsInRange = true

func _on_body_exited(body):
	itemIsInRange = false


func _on_inventory_hud_item_picked_up(item):
	pass # Replace with function body.
