extends Node2D
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"
@onready var portal: Area2D = $Portal
@onready var player: CharacterBody2D = $Player

var currently_teleporting

signal start_signal_setoff

func _ready() -> void:
	
	# NOTE DO NOT FORGET TO TURN THIS BACK ON IF OFF!!!
	match Ui.last_location:
		"start":
			Ui.show()
			PauseMenu.can_open = false
			
			player.can_move = false
			player.position = Vector2(5013.0, 7417.0)
			
			Ui.fade_animation.play("fade_out")
			await Ui.fade_animation.animation_finished
			
			Ui.item_menu.can_open = true
			player.can_move = true
			
		"town":
			player.position = Vector2(6469.0, 1144.0)
			player.can_move = false
			player.anim_sprite.set_animation("side_idle")
			
			Ui.fade_animation.play("fade_out")
			await Ui.fade_animation.animation_finished
			player.can_move = true
			Ui.currently_teleporting = false
		"farm":
			player.position = Vector2(player.position.x, player.position.y)
			player.can_move = false
			player.anim_sprite.set_animation("side_idle")
			
			Ui.fade_animation.play("fade_out")
			await Ui.fade_animation.animation_finished
			player.can_move = true
			Ui.currently_teleporting = false
	
	Ui.show()
	PauseMenu.can_open = true
	Ui.item_menu.can_open = true
	music.play()
	wind.play()
	
	
	


func _process(delta: float) -> void:
	if portal.overlaps_body(player) and not Ui.currently_teleporting:
		Ui.currently_teleporting = true
		
		
		player.can_move = false
		Ui.fade_animation.play("fade_in")
		await Ui.fade_animation.animation_finished
		
		Ui.last_location = "farm"
		Global.next_scene = "res://terrain/town.tscn"
		get_tree().change_scene_to_packed(Global.loading_screen)
		
		

func _on_start_pressed() -> void:
	start_signal_setoff.emit()
	print("start pressed")
