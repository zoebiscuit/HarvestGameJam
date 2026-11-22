extends Node

var point: Texture2D = preload("res://img/point.png")
var button_sfx: AudioStream = preload("res://SFX/Actions/Button_Pressed_09.ogg")
var button_sfx2: AudioStream = preload("res://SFX/Dialogue/Dialogue_Blip_16.ogg")
var audio_player := AudioStreamPlayer.new()

var next_scene : String 

var loading_screen = preload("res://loading_screen.tscn")

func _ready() -> void:
	add_child(audio_player)
	
	for button: BaseButton in get_tree().get_nodes_in_group("normal_buttons"):
		button.pressed.connect(_on_group_button_pressed.bind(button))
		button.mouse_entered.connect(hover.bind(button))

func _on_group_button_pressed(button: BaseButton) -> void:
	audio_player.volume_db = -5.0
	audio_player.stream = button_sfx
	audio_player.play()

func hover(button: BaseButton):
	audio_player.volume_db = -15.5
	audio_player.stream = button_sfx2
	audio_player.play()
