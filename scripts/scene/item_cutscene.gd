extends item

@export var animationToPlay = ""
@onready var animationPlayer = get_node("../AnimationPlayer")

func _on_item_picked_up():
	animationPlayer.play(animationToPlay)
	print("cutscene triggers")

func _process(delta):
	if Input.is_action_pressed("pick_up_item") and itemIsInRange and is_visible():
		itemPickedUp.emit(itemName)
		# handle what happens when inventory is full in the future
		hide()
		_on_item_picked_up()
