extends Button

var base_text
var arrow1 = ">"
var arrow2 = "<"

func _ready() -> void:
	base_text = text
	text = " " + text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	text = arrow1 + base_text 

func _on_mouse_exited() -> void:
	text = base_text
