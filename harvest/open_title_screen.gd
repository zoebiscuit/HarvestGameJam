extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_title_screen_start() -> void:
	
	Ui.last_location = "start"
	Ui.fade_animation.play("fade_in")
	await Ui.fade_animation.animation_finished
	
	Global.next_scene = "res://main.tscn"
	get_tree().change_scene_to_packed(Global.loading_screen)
