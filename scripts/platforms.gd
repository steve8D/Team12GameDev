extends StaticBody2D

var player_on_platform: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("s") and player_on_platform:
		set_collision_layer_value(2, false)

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "player"):
		player_on_platform = true
		print("Player is on platform")


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "player"):
		player_on_platform = false
		set_collision_layer_value(2, true)
		print("Player is not on platform")
