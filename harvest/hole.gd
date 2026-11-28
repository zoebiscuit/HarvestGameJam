extends Sprite2D

@onready var planted_seeds = $"../PlantedSeeds/Area2D"
#@onready var _area = $Area2D

var support = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self/$Area2D.area_entered.connect(_on_area_2d_area_entered) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Setup(target_x: float):
	global_position.x = target_x
	global_position.y = 801
	set_process(true)


func _on_area_2d_area_entered(area: Area2D) -> void:
	#if _area.overlaps_area(planted_seeds):
	if area == planted_seeds:
		Ui.add_support(5)
		print("hi")
		support = true
	#if _area.overlaps_area(planted_seeds):
		#print("touching")# Replace with function body.
