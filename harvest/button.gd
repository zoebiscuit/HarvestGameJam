extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	var tween = create_tween()
	
	z_index = 0
	
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.1)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	
	z_index = 2
	
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 0.1)
