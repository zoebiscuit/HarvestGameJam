extends Node2D
@onready var label: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/RichTextLabel

@export var area_detection : Area2D
@export var player : CharacterBody2D 

@onready var voice_neutral: AudioStreamPlayer2D = $VoiceNeutral
@onready var voice_negative: AudioStreamPlayer2D = $VoiceNegative
@onready var voice_positive: AudioStreamPlayer2D = $VoicePositive
@onready var voice_angry: AudioStreamPlayer2D = $VoiceAngry

var within_area : bool = true
var talking : bool

signal advance
signal left_conversation

func _ready() -> void:
	await say("Hello! This is a test!")
	await say("This is the second line.")

func _process(delta: float) -> void:
	#if player in area_detection.get_overlapping_bodies():
		#within_area = true
	#else: within_area = false
	
	if Input.is_action_just_pressed("enter"):
		advance.emit()

func say(message: String, emotion := "neutral"):
	if within_area:
		
		label.visible_ratio = 0.0
		
		show()
		talking = true
		var tween = create_tween()
		var text_size = len(label.text) * 0.05
		
		label.text = message
		
		match emotion:
			"neutral": voice_neutral.play()
			"angry": voice_angry.play()
			"positive": voice_positive.play()
			"negative": voice_negative.play()
		
		tween.tween_property(label, "visible_ratio", 1.0, text_size)
		
		await advance
		talking = false
		hide()
		
	else:
		left_conversation.emit()
