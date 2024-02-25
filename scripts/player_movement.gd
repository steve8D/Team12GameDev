extends CharacterBody2D

const SPEED = 200.0
const SPRINT_SPEED = 400.0
const JUMP_VELOCITY = -600.0

var sprinting = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready
var sprintTimer = $SprintTimer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_pressed("jump_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle drop from platform
	if Input.is_action_pressed("jump_down") and not is_on_floor():
		velocity.y = -JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if sprinting:
		velocity.x = direction * SPRINT_SPEED
	
	check_for_sprint()
	move_and_slide()
	
func _on_sprint_timer_timeout():
	sprinting = false
	
func check_for_sprint():
	if Input.is_action_just_pressed("sprint") and is_on_floor():
		sprinting = true
		sprintTimer.start()
	
	if Input.is_action_just_released("sprint"):
		sprinting = false
