extends Label

func showLabel():
	show()
	if get_node("../CollisionShape2D"):
		get_node("../CollisionShape2D").set_deferred("disabled", true)

func _on_area_2d_body_entered(body):
	if (body.name == "player"):
		showLabel()
