extends StaticBody2D
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if area_2d.overlaps_body(player):
		
		sprite_2d.material = Global.highlight_material
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://minigame_planting.tscn")
		
	else: sprite_2d.material = null
