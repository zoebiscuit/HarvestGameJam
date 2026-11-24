extends Sprite2D

@export var fall_speed: float = 0

var init_y_pos: float = -700

func _init():
	set_process(false)

func _ready():
	$Timer.start()
	fall_speed = 3.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(0, fall_speed)
	
	#time it reaches spot (4.71085366666674)
	if global_position.y > 400.0 and not $Timer.is_stopped():
		print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		
func Setup(target_x: float, target_frame: int):
	global_position = Vector2(target_x, init_y_pos)
	frame = target_frame
	set_process(true)


func _on_destroy_timer_timeout() -> void:
	queue_free()
