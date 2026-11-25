extends Control
@onready var selection_wheel: Control = $SelectionWheel
@onready var current_selection: Control = $current_selection

var can_open : bool = true
var selected_null : WheelOption

func _ready() -> void:
	selection_wheel.hide()
	current_selection.show()
	
	selected_null = selection_wheel.options[1]
	
func _process(delta: float) -> void:
	
	current_selection.current_selection = selected_null
	
	if can_open:
		
		show()
		
		if Input.is_action_just_pressed("menu"):
			selection_wheel.show()
			current_selection.hide()
			
		elif Input.is_action_just_released("menu"):
			selected_null = selection_wheel.options[
				selection_wheel.last_select]
			
			selection_wheel.hide()
			current_selection.show()
	else: hide()
