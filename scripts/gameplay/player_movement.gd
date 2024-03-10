extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -600.0
const SPRINT_SPEED = 400.0

const RUNNING_STAMINA_COST = 50
const STAMINA_RECOVERY_RATE = 100
const JUMP_STAMINA_COST = 20

var stamina = 100
var sprinting = false
signal staminaValue(value)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var healthBar = $StaminaBar

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	handle_vertical_movement(delta)
	handle_lateral_movement(delta)
	check_for_sprint()	
	handle_sprint(direction, delta)
	move_and_slide()
	
func _on_sprint_timer_timeout():
	sprinting = false

# Helper functions
func check_for_sprint():
	if Input.is_action_just_pressed("sprint") and is_on_floor() and stamina >= 0:
		sprinting = true
	
	if Input.is_action_just_released("sprint") or stamina <= 0:
		sprinting = false

func handle_sprint(direction, delta):
	if sprinting:
		velocity.x = direction * SPRINT_SPEED
		stamina -= delta * RUNNING_STAMINA_COST
		staminaValue.emit(stamina)
	else:
		if stamina <= 100:
			stamina += delta * STAMINA_RECOVERY_RATE
			staminaValue.emit(stamina)

func handle_vertical_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_pressed("jump_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stamina -= JUMP_STAMINA_COST
	
	# Handle drop from platform
	if Input.is_action_pressed("jump_down") and not is_on_floor():
		velocity.y = -JUMP_VELOCITY

func handle_lateral_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
