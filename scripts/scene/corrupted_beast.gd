extends RigidBody2D

@export var speed = 0

signal endGame()

func _process(delta):
	# Move the enemy to the right continuously
	linear_velocity.x = speed

func _on_body_entered(body):
	if body.name == "player":
		print("end game")
		var playerHealth = get_node("../Player Hud/HealthBar")
		# playerHealth.value = 0
		endGame.emit()

func _on_exit_prologue_trigger_area_body_entered(body):
	hide()
