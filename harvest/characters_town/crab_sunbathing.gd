extends StaticBody2D

@export var player : CharacterBody2D
@export var player_remote : RemoteTransform2D
@export var remote : RemoteTransform2D
@export var camera : Camera2D

@onready var area_2d: Area2D = $Area2D
@onready var crab: Node2D = $SpeechBubble

var choice: int = 1

func _ready() -> void:
	player_remote.remote_path = camera.get_path()
	
	remote.update_position = false
	remote.remote_path = camera.get_path()

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if area_2d.overlaps_body(player) and event.is_action_pressed("enter"):
		if !Global.crab_start:
			start_conversation()
		elif Global.crab_casual:
			random_convo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_conversation():
	Ui.hide()
	Global.crab_start = true
	player.can_move = false
	
	remote.update_position = true
	player_remote.update_position = false
	
	await crab.say("[shake]Who's the dude blocking the rays!!", "angry")
	await crab.say("Oh you the Grandpa?", "angry")
	await crab.say("...", "angry")
	await crab.say("You're his grandkid?", "neutral")
	await crab.say("[wave]That's rad man.", "poitive")
	await crab.say("Haven't had a problem with that guy.", "positive")
	await crab.say("[wave]He really knows how to chill, more than me.", "neutral")
	await crab.say("[wave]Though a lot of people misunderstand him sometimes.", "neutral")
	await crab.say("A guy's gotta sleep, and he does it a bit too much.", "neutral")
	await crab.say("[wave]People have gotten on his bad side when waking him.", "neutral")
	await crab.say("...", "neutral")
	await crab.say("[wave]He's fine with you? Hm.", "neutral")
	await crab.say("[wave]He must have a soft spot for family, mannn.", "neutral")
	await crab.say("[wave]Anyways, what'd you need man?", "neutral")
	await crab.say("[wave]...", "neutral")
	await crab.say("[wave]Oh I heard man, big wigs are taking the farm.", "neutral")
	await crab.say("[wave]I'm all for supporting you, big authority is my arch nemesis.", "neutral")
	await crab.say("[wave]I'm actually from the big country more mainland.", "neutral")
	await crab.say("[wave]I only moved here cuz it's more simple, less stress for the bod you know.", "neutral")
	await crab.say("[wave]Just tell me when I can help dude, I'm LOADED in the bicep department.", "neutral")
	
	Ui.add_support(5)
	
	player.can_move = true
	remote.update_position = false
	player_remote.update_position = true
	Ui.show()
	
	await get_tree().create_timer(1.0).timeout
	Global.crab_casual = true
	
func random_convo():
	
	Ui.hide()
	player.can_move = false
	remote.update_position = true
	player_remote.update_position = false
	
	Global.crab_casual = false
	
	match choice:
		1: 
			await crab.say("[wave]*Snore*", "angry")
		2: 
			await crab.say("No...", "neutral")
			await crab.say("[wave]Don't take the self tannnn....", "angry")
		3: 
			await crab.say("1 push-up, 2 push-ups, 3 push...", "neutral")
	
	remote.update_position = false
	player_remote.update_position = true
	Ui.show()
	
	if choice > 2:
		choice = 1
	else:
		choice += 1
	
	player.can_move = true
	await get_tree().create_timer(1.0).timeout
	Global.crab_casual = true
