extends AnimationPlayer

func _on_corrupted_beast_end_game():
	play("fade_to_black")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		play("enemy chase checkpoint")
	elif anim_name == "enemy chase checkpoint":
		play("fade_to_normal")
