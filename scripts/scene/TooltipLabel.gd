extends Label

func showLabel():
	var player_pos = get_tree().current_scene.get_node("player").get_position()
	set_position(Vector2(player_pos.x, player_pos.y - 50))
	show()
	if get_node("../CollisionShape2D"):
		get_node("../CollisionShape2D").set_deferred("disabled", true)

func _on_area_2d_body_entered(body):
	if (body.name == "player"):
		showLabel()
