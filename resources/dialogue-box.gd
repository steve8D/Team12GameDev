extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_player_trigger_dialogue():
	show()


func _on_player_end_dialogue():
	hide()
