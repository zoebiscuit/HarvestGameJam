extends Sprite2D

@export var x_speed: float = 0

var init_y_pos: float = -700


var has_passed: bool = false
var pass_threshold = 300.0

func _init():
	set_process(false)

func _ready():
	$Timer.start()
	x_speed = 3.5
	
	var tween = get_tree().create_tween()
	tween.set_loops()
	tween.tween_property(self, "global_position", Vector2(1900.0,0), 4)
	tween.tween_property(self, "global_position", Vector2(100,0), 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#time it reaches spot (4.71085366666674)
	if global_position.y > 400.0 and not $Timer.is_stopped():
		# print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true
		
func Setup(target_x: float):
	global_position = Vector2(target_x, init_y_pos)
	set_process(true)


#func _on_destroy_timer_timeout() -> void:
	#queue_free()
