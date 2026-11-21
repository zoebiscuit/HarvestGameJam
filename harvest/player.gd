extends CharacterBody2D
@onready var footstep_1: AudioStreamPlayer2D = $Footstep1
@onready var footstep_2: AudioStreamPlayer2D = $Footstep2
@onready var footstep_3: AudioStreamPlayer2D = $Footstep3
@onready var footstep_4: AudioStreamPlayer2D = $Footstep4

@export var sound_effect : AudioStreamPlayer2D

const SPEED = 300.0
const SPRINT_SPEED = 500.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	#var step_played : bool = false 
	var input_vector = Vector2.ZERO
	#var rand_footstep = randi_range(1, 5)
	var actual_speed : float
	
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	
	if Input.is_action_pressed("shift"):
		actual_speed = SPRINT_SPEED
	else: actual_speed = SPEED
		
	velocity = input_vector * actual_speed

	move_and_slide()

#func play_step(rand_footstep: int):
	#match rand_footstep:
			#1: footstep_1.play()
			#2: footstep_2.play()
			#3: footstep_3.play()
			#4: footstep_4.play()
