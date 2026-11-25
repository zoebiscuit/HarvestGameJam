extends Sprite2D


@export var falling_key = preload("res://falling_key.tscn")
@export var key_name: String = ""

#var falling_key_queue = []

var current_falling_key = null

func _ready():
	if name=="KeyListener" and not is_instance_valid(current_falling_key):
		CreateFallingKey()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if falling_key_queue.size() > 0:
		#if is_instance_valid(falling_key_queue.front()):
			#if falling_key_queue.front().has_passed:
				#falling_key_queue.pop_front()
				
				
		if Input.is_action_just_pressed(key_name):
			#var key_to_pop = falling_key_queue.pop_front()
		
			#var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			#print(distance_from_pass)
			
			#key_to_pop.queue_free()
			
			CreateFallingKey()
		
func CreateFallingKey():
	if not is_instance_valid(current_falling_key):
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x) # frame + 4
			
		current_falling_key = fk_inst
		#falling_key_queue.push_back(fk_inst)


func _on_random_spawn_timer_timeout() -> void:
	#CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(1, 15)
	$RandomSpawnTimer.start()
