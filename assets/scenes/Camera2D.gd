extends Camera2D 

var shakeIntensity: float = 0
var shakeNoise: FastNoiseLite
var timer: SceneTreeTimer

func _ready():
	shakeNoise = FastNoiseLite.new()
	
func _process(delta):
	if timer and timer.get_time_left() > 0:
		shakeCamera()
		
func shakeCamera():
	offset.x = offset.x + shakeNoise.get_noise_1d(randi()) * shakeIntensity  * shakeIntensity
	offset.y = offset.y + shakeNoise.get_noise_1d(randi()) * shakeIntensity  * shakeIntensity

func _on_timer_timeout():
	print("buh")

func start_shake(intensity: float, length: int):
	shakeIntensity = intensity
	timer = get_tree().create_timer(length)
	print("start")
