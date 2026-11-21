extends Node2D
@onready var label: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/RichTextLabel

@onready var voice_neutral: AudioStreamPlayer2D = $VoiceNeutral
@onready var voice_negative: AudioStreamPlayer2D = $VoiceNegative
@onready var voice_positive: AudioStreamPlayer2D = $VoicePositive
@onready var voice_angry: AudioStreamPlayer2D = $VoiceAngry
@onready var _advance: AudioStreamPlayer2D = $Advance

var talking : bool

signal advance
signal left_conversation

func _ready() -> void:
	hide()
	label.text = ""
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter") and talking:
		advance.emit()

func say(message: String, emotion := "neutral, angry, positive, negative"):
	
	label.visible_ratio = 0.0
	
	show()
	talking = true
	var tween = create_tween()
	var text_size = len(label.text) * 0.05
	
	label.text = message
	
	match emotion:
		"neutral, angry, positive, negative": voice_neutral.play()
		"neutral": voice_neutral.play()
		"angry": voice_angry.play()
		"positive": voice_positive.play()
		"negative": voice_negative.play()
	
	tween.tween_property(label, "visible_ratio", 1.0, text_size)
	
	await advance
	_advance.play()
	talking = false
	hide()
		
