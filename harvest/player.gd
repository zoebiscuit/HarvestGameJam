extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_1: AudioStreamPlayer2D = $Footstep1
@onready var footstep_2: AudioStreamPlayer2D = $Footstep2
@onready var footstep_3: AudioStreamPlayer2D = $Footstep3
@onready var footstep_4: AudioStreamPlayer2D = $Footstep4

@export var sound_effect: AudioStreamPlayer2D

const SPEED = 500.0
const SPRINT_SPEED = 800.0
const JUMP_VELOCITY = -400.0

const STEP_FRAMES := [1, 3]
const WALK_ANIMS := ["down_walk", "side_walk", "up_walk"]

var facing_dir := "down"
var last_footstep := -1

var can_move : bool = true

func _ready() -> void:
	anim_sprite.frame_changed.connect(_on_anim_frame_changed)


func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	if !can_move:
		return
	
	if Input.is_action_pressed("up"):
		input_vector.y -= 1.0
	if Input.is_action_pressed("down"):
		input_vector.y += 1.0
	if Input.is_action_pressed("left"):
		input_vector.x -= 1.0
	if Input.is_action_pressed("right"):
		input_vector.x += 1.0

	input_vector = input_vector.normalized()

	var is_moving := input_vector != Vector2.ZERO
	var is_sprinting := Input.is_action_pressed("shift") and is_moving
	var actual_speed := SPRINT_SPEED if is_sprinting else SPEED

	velocity = input_vector * actual_speed
	move_and_slide()

	update_animation(input_vector, is_moving, is_sprinting)


func update_animation(move_dir: Vector2, is_moving: bool, is_sprinting: bool) -> void:
	if is_moving:
		if abs(move_dir.x) >= abs(move_dir.y):
			facing_dir = "side"
			anim_sprite.flip_h = move_dir.x < 0.0
		elif move_dir.y < 0.0:
			facing_dir = "up"
			anim_sprite.flip_h = false
		else:
			facing_dir = "down"
			anim_sprite.flip_h = false

	var state := "walk" if is_moving else "idle"
	var anim_name := "%s_%s" % [facing_dir, state]

	anim_sprite.speed_scale = 1.4 if is_sprinting else 1.0

	if anim_sprite.animation != anim_name:
		anim_sprite.play(anim_name)


func _on_anim_frame_changed() -> void:
	if anim_sprite.animation in WALK_ANIMS and anim_sprite.frame in STEP_FRAMES:
		play_step()


func play_step(step_index: int = -1) -> void:
	var chosen := step_index
	if chosen not in range(1, 5):
		chosen = randi_range(1, 4)
		while chosen == last_footstep:
			chosen = randi_range(1, 4)

	last_footstep = chosen

	match chosen:
		1:
			footstep_1.play()
		2:
			footstep_2.play()
		3:
			footstep_3.play()
		4:
			footstep_4.play()
