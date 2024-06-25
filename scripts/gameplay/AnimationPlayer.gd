extends AnimationPlayer

func _on_corrupted_beast_end_game():
	play("fade_to_black")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		play("enemy chase test")
	elif anim_name == "enemy chase test":
		play("fade_to_normal")
