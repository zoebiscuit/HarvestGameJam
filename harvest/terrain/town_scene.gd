extends Node2D
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"
@onready var player: CharacterBody2D = $Player
@onready var portal: Area2D = $Portal

func _ready() -> void:
	
	match Ui.last_location:
		"farm":
			player.can_move = false
			player.anim_sprite.set_animation("side_idle")
			
			Ui.fade_animation.play("fade_out")
			await Ui.fade_animation.animation_finished
			player.can_move = true
			Ui.currently_teleporting = false
			
		"neighborhood": 
			pass
			
	if !Global.politician_cutscene:
		#TODO : The main scene with the politician and the townspeople go here
		pass
	
	# NOTE DO NOT FORGET TO TURN THIS BACK ON IF OFF!!!
	
	music.play()
	wind.play()


func _process(delta: float) -> void:
	if portal.overlaps_body(player) and not Ui.currently_teleporting:
		Ui.currently_teleporting = true
		
		player.can_move = false
		
		Ui.show()
		Ui.fade_animation.play("fade_in")
		await Ui.fade_animation.animation_finished
		
		Ui.last_location = "town"
		Global.next_scene = "res://main.tscn"
		get_tree().change_scene_to_packed(Global.loading_screen)
