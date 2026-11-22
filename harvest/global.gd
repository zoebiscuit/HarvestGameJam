extends Node

var point: Texture2D = preload("res://img/point.png")
var button_sfx: AudioStream = preload("res://SFX/Actions/Button_Pressed_09.ogg")
var audio_player := AudioStreamPlayer.new()

func _ready() -> void:
	add_child(audio_player)
	audio_player.stream = button_sfx
	
	for button: BaseButton in get_tree().get_nodes_in_group("normal_buttons"):
		button.pressed.connect(_on_group_button_pressed.bind(button))

func _on_group_button_pressed(button: BaseButton) -> void:
	audio_player.play()
