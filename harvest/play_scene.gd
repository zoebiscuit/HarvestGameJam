extends Node2D
@onready var boat_scene_animation: AnimationPlayer = $Boat/AnimationPlayer
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"


func _ready() -> void:
	
	# NOTE DO NOT FORGET TO TURN THIS BACK ON IF OFF!!!
	
	boat_scene_animation.play("opening_boat_scene") 
	Ui.item_menu.can_open = false
	await boat_scene_animation.animation_finished
	
	Ui.show()
	Ui.item_menu.can_open = true
	music.play()
	wind.play()


func _process(delta: float) -> void:
	pass
