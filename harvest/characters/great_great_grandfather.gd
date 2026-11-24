extends StaticBody2D
@onready var snoring: AudioStreamPlayer2D = $Snoring
@onready var speech_bubble: Node2D = $SpeechBubble
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var player : CharacterBody2D

func _ready() -> void:
	snoring.play()
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if area_2d.overlaps_body(player):
		
		if !Global.grandpa_start_debrief and event.is_action_pressed("enter"):
			start_conversation()
			
func start_conversation():
	player.can_move = false
	Global.grandpa_start_debrief = true
	snoring.stop()
	await speech_bubble.say("mmmmmm...", "neutral")
	await speech_bubble.say("mmmmmmHM...!", "neutral")
	await speech_bubble.say("Who is it!?", "positive")
	await speech_bubble.say("Oh. It's you!", "positive")
	await speech_bubble.say("I'm in dire need of your help!", "positive")
	await speech_bubble.say("You must've read my letter.", "positive")
	await speech_bubble.say("An [shake]EVIL[/shake] man has entered the island,", "neutral")
	await speech_bubble.say("and my business has gone down since.", "neutral")
	await speech_bubble.say("I, of course, am doing well,", "neutral")
	await speech_bubble.say("but I've become maybe too weak to take care of my garden alone.", "neutral")
	await speech_bubble.say("I don't care for the politician's name,", "neutral")
	await speech_bubble.say("but I remember he had a oddly long nose...", "neutral")
	await speech_bubble.say("Anyone can tell just by looking...", "negative")
	await speech_bubble.say("...but your old great great grandpa is sickly.", "negative")
	await speech_bubble.say("You're a gift the sea has brought to me, grandchild.", "positive")
	player.can_move = true
