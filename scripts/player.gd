extends CharacterBody2D

signal triggerDialogue
signal endDialogue

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_area_2d_body_entered(body):
	print("Cutscene triggered")
	triggerDialogue.emit()


func _on_area_2d_body_exited(body):
	endDialogue.emit()