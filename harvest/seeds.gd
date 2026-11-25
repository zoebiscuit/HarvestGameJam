extends Sprite2D

@export var KEY_NAME: String = ""

var tween = null
var current_position_x = 0.0
var speed_y = 3.5
var init_y = position.y
var seed_count = -1
var speed_y_progressive = 1.0

var planted_seeds = preload("res://planted_seeds.tscn")
var current_planted_seed = null

@onready var shovel = $"../Shovel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	
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
		
		if position.y < 800 and seed_count <=4 and seed_count != -1:
			current_position_x = position.x
			tween = get_tree().create_tween()
			tween.tween_property(self, "global_position:y", 801.0, .5)
			await get_tree().create_timer(.5).timeout
			CreateNewPlantedSeed()
			
			
			
			print("seed:" + str(seed_count))
			
			speed_y_progressive = speed_y_progressive/2
			tween.kill()
		position.y = init_y
		print(speed_y_progressive)
		
		tween = get_tree().create_tween()
		tween.set_loops()
		tween.tween_property(self, "global_position:x", 1900.0,  .5 +speed_y_progressive)
		tween.tween_property(self, "global_position:x", 0.0, .5 + speed_y_progressive)
		
	if seed_count >= 5:
		self.hide()
		seed_count = -1
		
			
func CreateNewPlantedSeed():
	seed_count += 1
	var planted_inst = planted_seeds.instantiate()
	get_tree().get_root().call_deferred("add_child", planted_inst)
	planted_inst.Setup(current_position_x) 
		
	current_planted_seed = planted_inst
