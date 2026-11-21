extends Node2D
@onready var snoring: AudioStreamPlayer2D = $Snoring
@onready var speech_bubble: Node2D = $SpeechBubble

@export var player : CharacterBody2D

var _snoring := true

func _ready() -> void:
	snoring.play()
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if _snoring and event.is_action_pressed("enter"):
		start_conversation()
		
func start_conversation():
	_snoring = false
	snoring.stop()
	await speech_bubble.say("mmmmmm...", "neutral")
	await speech_bubble.say("mmmmmmHM...!", "neutral")
	await speech_bubble.say("Who is it!?", "positive")
	await speech_bubble.say("Oh.
	It's you!", "positive")
