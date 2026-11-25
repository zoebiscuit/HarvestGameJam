extends Control
@onready var icon: TextureRect = $Icon
@onready var count: Label = $Count

@export var current_selection : WheelOption

var display_atlas := AtlasTexture.new()

func _ready() -> void:
	icon.texture = display_atlas

func _process(delta: float) -> void:
	if current_selection:
		display_atlas.atlas = current_selection.atlas
		display_atlas.region = current_selection.region
		
		if current_selection.count < 0: 
			count.hide()
		else: 
			count.show()
			count.text = str(current_selection.count)
