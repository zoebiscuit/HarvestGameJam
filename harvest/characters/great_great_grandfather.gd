extends Node2D
@onready var snoring: AudioStreamPlayer2D = $Snoring
@onready var speech_bubble: Node2D = $SpeechBubble

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speech_bubble.player = player


func start_conversation():
	pass
