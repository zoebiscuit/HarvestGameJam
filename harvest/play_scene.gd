extends Node2D
@onready var boat_scene_animation: AnimationPlayer = $Boat/AnimationPlayer
@onready var item_menu: Control = $"../UI/ItemMenu"
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"


func _ready() -> void:
	
	boat_scene_animation.play("opening_boat_scene")
	item_menu.can_open = false
	await boat_scene_animation.animation_finished
	item_menu.can_open = true
	music.play()
	wind.play()


func _process(delta: float) -> void:
	pass
