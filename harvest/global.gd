extends Node

var point = load("res://img/point.png")

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	Input.set_custom_mouse_cursor(point, Input.CURSOR_POINTING_HAND)
