extends CharacterBody2D

enum MOVE_SET {SPRINTING=1, WALKING=2, JUMPING=3, STANDING=4}

# Character Move Speed Settings
const SPEED = 200.0
const JUMP_VELOCITY = -530.0
const DROP_VELOCITY = 400
const SPRINT_SPEED = 500.0

# Character Stamina Settings
const RUNNING_STAMINA_COST = 50
const STAMINA_RECOVERY_RATE = 20
const JUMP_STAMINA_COST = 20

# File variables
var stamina = 100
var state = MOVE_SET.STANDING
signal staminaValue(value)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animation_player = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "jump_up", "jump_down")
	handle_vertical_movement(direction, delta)
	handle_lateral_movement(direction, delta)
	check_for_sprint()	
	handle_sprint(direction, delta)
	move_and_slide()
	
func _on_sprint_timer_timeout():
	state = MOVE_SET.WALKING
	# set timer for cooldown

# Helper functions
func check_for_sprint():
	if Input.is_action_pressed("sprint") and is_on_floor() and stamina >= 0:
		state = MOVE_SET.SPRINTING
		
	if Input.is_action_just_released("sprint") or stamina <= 0:
		state = MOVE_SET.WALKING

func handle_sprint(direction, delta):
	if state == MOVE_SET.SPRINTING and direction:
		velocity.x = direction.x * SPRINT_SPEED
		stamina -= delta * RUNNING_STAMINA_COST
		staminaValue.emit(stamina)
		process_animation()
	else:
		if stamina <= 100:
			state == MOVE_SET.WALKING
			stamina += delta * STAMINA_RECOVERY_RATE
			staminaValue.emit(stamina)

func handle_vertical_movement(direction, delta):
	# Add the gravity.
	if not is_on_floor():
		state = MOVE_SET.JUMPING
		velocity.y += gravity * delta
		process_animation()
		
	# Handle Jump.
	if direction.y < 0 and is_on_floor():
		state = MOVE_SET.JUMPING
		process_animation()
		if state == MOVE_SET.SPRINTING:
			velocity.x = direction.x * SPRINT_SPEED
		velocity.y = JUMP_VELOCITY
		stamina -= JUMP_STAMINA_COST
	
	# Handle drop from platform
	if direction.y > 0 and not is_on_floor():
		state = MOVE_SET.JUMPING
		process_animation()
		velocity.y = DROP_VELOCITY
	
func handle_lateral_movement(direction, delta):
	if direction.x:
		if is_on_floor():
			state = MOVE_SET.WALKING
		velocity.x = direction.x * SPEED
		process_animation()
	else:
		if is_on_floor():
			state = MOVE_SET.STANDING
		velocity.x = move_toward(velocity.x, 0, 20)
		process_animation()

func process_animation():
	if velocity.x < 0:
		_animation_player.flip_h = false
	else:
		_animation_player.flip_h = true
	
	if state == MOVE_SET.SPRINTING:
		_animation_player.play("running")
		_animation_player.speed_scale = 1.5
	elif state == MOVE_SET.WALKING:
		_animation_player.play("running")
		_animation_player.speed_scale = 1.0
	elif state == MOVE_SET.JUMPING:
		# play animation once
		_animation_player.play("jumping")
	else:
		_animation_player.play("default")
