extends StaticBody2D

var player_on_platform: bool = false

func _process(delta):
	if Input.is_action_pressed("jump_down") and player_on_platform:
		set_collision_layer_value(2, false)

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "player"):
		player_on_platform = true
		set_collision_layer_value(2, true)


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "player"):
		player_on_platform = false
		set_collision_layer_value(2, false)
