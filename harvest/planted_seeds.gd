extends Sprite2D
@onready var area2d = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Setup(target_x: float):
	global_position.x = target_x
	global_position.y = 801
	set_process(true)
