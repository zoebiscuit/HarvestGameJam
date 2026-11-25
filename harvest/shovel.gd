extends Sprite2D

@export var KEY_NAME: String = ""

var tween = null
var current_position_x = 0.0
var speed_y = 3.5
var current_hole = null
var hole = preload("res://hole.tscn")
var init_y = position.y
var hole_count = 0
var speed_y_progressive = 1.0

@onready var seeds = $"../Seeds"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tween = get_tree().create_tween()
	
	tween.set_loops()
	tween.tween_property(self, "global_position:x", 1900.0, 1)
	tween.tween_property(self, "global_position:x", 0.0, 1)
	Ui.show()
	Ui.item_menu.can_open = false # Replace with function body.
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		tween.kill()
		
		if position.y < 800 and hole_count <=4 and hole_count > -1:
			current_position_x = position.x
			tween = get_tree().create_tween()
			tween.tween_property(self, "global_position:y", 801.0, .5)
			await get_tree().create_timer(.5).timeout
			CreateNewHole()
			speed_y_progressive = speed_y_progressive/2
			tween.kill()
		position.y = init_y
		print(speed_y_progressive)
		
		tween = get_tree().create_tween()
		tween.set_loops()
		tween.tween_property(self, "global_position:x", 1900.0,  .5 +speed_y_progressive)
		tween.tween_property(self, "global_position:x", 0.0, .5 + speed_y_progressive)
		
	if hole_count > 4:
		self.hide()
		seeds.show()
		hole_count = -1
		seeds.seed_count = 0
		
			
func CreateNewHole():
		var hole_inst = hole.instantiate()
		get_tree().get_root().call_deferred("add_child", hole_inst)
		hole_inst.Setup(current_position_x) 
			
		current_hole = hole_inst
		hole_count += 1
		print("holes: " + str(hole_count))
			
			
		
		
		
