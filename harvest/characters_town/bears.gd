extends StaticBody2D

@export var player : CharacterBody2D
@export var player_remote : RemoteTransform2D
@export var remote : RemoteTransform2D
@export var camera : Camera2D

@onready var area_2d: Area2D = $Area2D

@onready var bear_1: Node2D = $Bear_1
@onready var bear_2: Node2D = $Bear_2
@onready var bear_3: Node2D = $Bear_3

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if area_2d.overlaps_body(player) and event.is_action_pressed("enter"):
		if !Global.bears_start:
			start_conversation()
		elif Global.bears_casual:
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_conversation():
	Ui.hide()
	Global.bears_start = true
	player.can_move = false
	remote.remote_path = camera.get_path()
	
	await bear_1.say("Aha, got you there Jon!", "positive")
	await bear_2.say("[shake]Oh, shut up.", "angry")
	await bear_1.say("[wave]Don't be such a-.", "neutral")
	await bear_1.say("Oh, who's the new kid?", "neutral")
	await bear_3.say("You look related to that old guy in that worn-down garden.", "neutral")
	await bear_3.say("...", "neutral")
	await bear_3.say("That's your great great grandpa?", "neutral")
	await bear_1.say("[wave]COOL.", "neutral")
	await bear_1.say("I've tried inviting the guy to a few games,", "neutral")
	await bear_1.say("But he's too much of a loner to join.", "neutral")
	await bear_2.say("Yeah.", "neutral")
	await bear_2.say("...", "neutral")
	await bear_2.say("You're here to clean it up a bit?", "neutral")
	await bear_3.say("You're a good kid!", "neutral")
	await bear_1.say("He'll need more help than ever,", "neutral")
	await bear_1.say("That DONKEY is trying to get reelected,", "neutral")
	await bear_1.say("and he's been bringing tech to our island of ours.", "neutral")
	await bear_1.say("He's trying to build a DATA CENTER on your garden.", "neutral")
	await bear_2.say("Yah, it's pretty bad.", "neutral")
	await bear_3.say("A lot of people here are for it cuz of the tech.", "neutral")
	await bear_3.say("I dunno about it though...", "neutral")
	await bear_1.say("I don't really mind,", "neutral")
	bear_2.say("!!!", "neutral")
	await bear_3.say("!!!", "neutral")
	
	await bear_1.say("I MEAN I don't mind more tech,", "neutral")
	await bear_1.say("though I want to support you and great great grandfather.", "neutral")
	await bear_1.say("We're willing to help out in anyway.", "positive")
	bear_3.say("Yeah.", "positive")
	await bear_2.say("Yeah!!", "positive")
	
	player.can_move = true
	player_remote.remote_path = camera.get_path()
	Ui.show()
	
