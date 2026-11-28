extends StaticBody2D

@export var player : CharacterBody2D
@export var player_remote : RemoteTransform2D
@export var remote : RemoteTransform2D
@export var camera : Camera2D

@onready var area_2d: Area2D = $Area2D
@onready var frog: Node2D = $SpeechBubble

var choice: int = 1

func _ready() -> void:
	player_remote.remote_path = camera.get_path()
	
	remote.update_position = false
	remote.remote_path = camera.get_path()

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if area_2d.overlaps_body(player) and event.is_action_pressed("enter"):
		if !Global.frog_start:
			start_conversation()
		elif Global.frog_casual:
			random_convo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_conversation():
	Ui.hide()
	Global.frog_start = true
	player.can_move = false
	
	remote.update_position = true
	player_remote.update_position = false
	
	await frog.say("Big Don hopped right off the stage!", "neutral")
	await frog.say("Hah! Get it?", "positive")
	await frog.say("...", "positive")
	await frog.say("What do think kid, you like the guy?", "positive")
	await frog.say("...", "positive")
	await frog.say("Oh, I see.", "neutral")
	await frog.say("Don tries his best to give our island the best.", "neutral")
	await frog.say("Sometimes somebody has to sacrifice something.", "neutral")
	await frog.say("That's why I donate to the cause. Give a bit to the Don.", "neutral")
	await frog.say("He'll use it towards the island.", "neutral")
	await frog.say("That farm was dying out anyways, sorry kid.", "neutral")
	
	player.can_move = true
	remote.update_position = false
	player_remote.update_position = true
	Ui.show()
	
	await get_tree().create_timer(1.0).timeout
	Global.frog_casual = true
	
func random_convo():
	
	Ui.hide()
	player.can_move = false
	remote.update_position = true
	player_remote.update_position = false
	
	Global.frog_casual = false
	
	match choice:
		1: 
			await frog.say("Wonder when he's coming back...", "neutral")
		2: 
			await frog.say("I don't really get along with the bears around here,", "neutral")
			await frog.say("They say I'm a slimy piece of trash.", "angry")
			await frog.say("Try not inheriting whatever attitude they got kid.", "angry")
		3: 
			await frog.say("He's never really specific on where the funds go,", "neutral")
			await frog.say("That just means I should trust him more.", "neutral")
	
	remote.update_position = false
	player_remote.update_position = true
	Ui.show()
	
	if choice > 2:
		choice = 1
	else:
		choice += 1
	
	player.can_move = true
	await get_tree().create_timer(1.0).timeout
	Global.frog_casual = true
