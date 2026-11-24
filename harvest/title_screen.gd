extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var button_sfx: AudioStream = preload("res://SFX/Actions/Button_Pressed_09.ogg")
var button_sfx2: AudioStream = preload("res://SFX/Dialogue/Dialogue_Blip_16.ogg")
var audio_player := AudioStreamPlayer.new()

func _ready() -> void:
	PauseMenu.can_open = false


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	animation_player.play("transition")
	await animation_player.animation_finished
	
	Global.next_scene = "res://main.tscn"
	get_tree().change_scene_to_packed(Global.loading_screen)


func _on_settings_pressed() -> void:
	Settings.open()
