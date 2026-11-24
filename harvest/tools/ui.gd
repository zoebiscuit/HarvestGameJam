extends CanvasLayer
@onready var fade_animation: AnimationPlayer = $FadeColor/AnimationPlayer

@onready var item_menu = $ItemMenu

var currently_teleporting : bool
var last_location : String = "start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
