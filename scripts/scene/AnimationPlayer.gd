extends AnimationPlayer

var playNextScene = false
@onready var audio: AudioStreamPlayer = $"background audio"
@onready var deathAudioSting = load("res://audio/Your_Light_Fades_Away.mp3")

func _on_corrupted_beast_end_game():
	play("fade_to_black")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black" and not playNextScene:
		play("enemy chase checkpoint")
	elif anim_name == "fade_to_black" and playNextScene:
		get_tree().change_scene_to_file("res://assets/scenes/village.tscn")
		playNextScene = false
	elif anim_name == "enemy chase checkpoint":
		play("fade_to_normal")

func _on_exit_prologue_trigger_area_body_entered(body):
	if (body.name == "player"):
		playNextScene = true
		audio.stream = deathAudioSting
		play("fade_to_black")

