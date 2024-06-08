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
const PLAYER_MAX_STAMINA = 100

# Player variables
var stamina = 100
var sprinting = false
var state = MOVE_SET.STANDING
signal staminaValue(value) # connects to StaminaBar HUD
signal playerStaminaIncreased() # connects to Inventory HUD
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animation_player = $AnimatedSprite2D

# Game variables
@onready var animationPlayer = get_node("../AnimationPlayer")

func _physics_process(delta):
	if not animationPlayer.is_playing():
		var direction = Input.get_vector("move_left", "move_right", "jump_up", "jump_down")
		handle_lateral_movement(direction, delta)
		handle_vertical_movement(direction, delta)
		check_for_sprint()	
		handle_sprint(direction, delta)
		process_animation()
		move_and_slide()
	elif not animationPlayer:
		print("attach animation player in the scene")
# Helper functions
func check_for_sprint():
	if Input.is_action_just_pressed("sprint") and is_on_floor() and stamina >= 0:
		state = MOVE_SET.SPRINTING
		sprinting = true
		
	if Input.is_action_just_released("sprint") or stamina <= 0:
		state = MOVE_SET.WALKING
		sprinting = false

func handle_sprint(direction, delta):
	if sprinting and direction:
		velocity.x = direction.x * SPRINT_SPEED
		stamina -= delta * RUNNING_STAMINA_COST
		staminaValue.emit(stamina)
		
	else:
		if stamina <= 100:
			stamina += delta * STAMINA_RECOVERY_RATE
			staminaValue.emit(stamina)

func handle_vertical_movement(direction, delta):
	# Add the gravity.
	if not is_on_floor():
		state = MOVE_SET.JUMPING
		velocity.y += gravity * delta
		
	# Handle Jump.
	if direction.y < 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stamina -= JUMP_STAMINA_COST
		state = MOVE_SET.JUMPING
	
	# Handle drop from platform
	if direction.y > 0 and not is_on_floor():
		state = MOVE_SET.JUMPING
		velocity.y = DROP_VELOCITY
	
func handle_lateral_movement(direction, delta):
	if direction.x:
		if is_on_floor():
			state = MOVE_SET.WALKING
		velocity.x = direction.x * SPEED
	else:
		if is_on_floor():
			state = MOVE_SET.STANDING
		velocity.x = move_toward(velocity.x, 0, 20)

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

func _on_inventory_hud_item_consumed(item):
	if stamina + item.staminaRecoverAmount <= PLAYER_MAX_STAMINA:
		playerStaminaIncreased.emit()
		stamina += item.staminaRecoverAmount

func _on_corrupted_beast_end_game():
	# stop taking user input and current animation
	set_physics_process(false)
	_animation_player.stop()
