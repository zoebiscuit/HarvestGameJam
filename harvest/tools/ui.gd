extends CanvasLayer
@onready var fade_animation: AnimationPlayer = $FadeColor/AnimationPlayer

@onready var item_menu = $ItemMenu

@onready var support_bar = $SupportBar
@onready var confidence_bar = $ConfidenceBar

var support : float = 0.0
var confidence : float = 100.0

var currently_teleporting : bool
var last_location : String = "start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	confidence_bar.value = confidence
	support_bar.value = support
	
	
func lose_confidence(amount : int):
	confidence -= amount
	
	if confidence <= 0:
		dead()
	
	return
	
func lose_support(amount : int):
	
	if support - amount <= 0:
		support = 0
	else:
		support -= amount
	
	return

func add_support(amount : int):
	
	if support + amount >= 100:
		support = 100
	else:
		support += amount
	
	return

func dead():
	pass # killed screen :(
