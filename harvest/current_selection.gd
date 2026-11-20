extends Control
@onready var icon: TextureRect = $Icon
@onready var count: Label = $Count

@export var current_selection : WheelOption

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	if current_selection:
		icon.texture = current_selection.atlas
		
		count.text = str(current_selection.count)
	
