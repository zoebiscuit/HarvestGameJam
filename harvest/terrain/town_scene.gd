extends Node2D
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"
@onready var player: CharacterBody2D = $Player
@onready var player_remote = $Player/RemoteTransform2D
@onready var portal: Area2D = $Portal
@onready var donkey: StaticBody2D = $Characters/politician

func _ready() -> void:
	wind.play()
	
	match Ui.last_location:
		"farm":
			player.can_move = false
			player.anim_sprite.set_animation("side_idle")
			player.position = Vector2i(800, 922)
			
			Ui.fade_animation.play("fade_out")
			await Ui.fade_animation.animation_finished
			player.can_move = true
			Ui.currently_teleporting = false
			
		"neighborhood": 
			pass
			
	if !Global.politician_cutscene:
		#TODO : The main scene with the politician and the townspeople go here
		
		await donkey.start_conversation()
		
		pass
	
	# NOTE DO NOT FORGET TO TURN THIS BACK ON IF OFF!!!
	
	music.play()
	#wind.play()


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
