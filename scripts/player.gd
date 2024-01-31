extends CharacterBody2D

@export var speed: int = 400
var mode: int = 0:
	set(value):
		mode = value
	get:
		return mode

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input():
	var input_direction = Input.get_vector("a", "d", "w", "s")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
