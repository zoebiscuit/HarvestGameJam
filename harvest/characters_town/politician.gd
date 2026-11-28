extends StaticBody2D

@export var player : CharacterBody2D
@export var player_remote : RemoteTransform2D
@export var remote : RemoteTransform2D
@export var camera : Camera2D

@onready var donkey: Node2D = $SpeechBubble

var choice: int = 1

func _ready() -> void:
	player_remote.remote_path = camera.get_path()
	
	remote.update_position = false
	remote.remote_path = camera.get_path()

# Called when the node enters the scene tree for the first time.
#func _unhandled_input(event: InputEvent) -> void:
	#if area_2d.overlaps_body(player) and event.is_action_pressed("enter"):
		#if !Global.donkey_start:
			#start_conversation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_conversation():
	show()
	
	$AudioStreamPlayer2D.play()
	
	Ui.hide()
	Global.politician_cutscene = true
	player.can_move = false
	
	await get_tree().create_timer(1.5).timeout
	
	remote.update_position = true
	player_remote.update_position = false
	
	await donkey.say("Hellooooo, Townspeople!", "positive")
	await donkey.say("I, Donovan Donkey, would love for your vote to go to ME!", "positive")
	await donkey.say("Don't waste a second. [wave]I certainly haven't!", "positive")
	await donkey.say("I've already brought basic essentials to you, and then some!", "positive")
	await donkey.say("Food Imports! Computers! Electricity!", "positive")
	await donkey.say("Don't rush to vote, BOLT!!", "positive")
	await donkey.say("[wave]Thank you, thank you.", "neutral")
	
	player.can_move = true
	remote.update_position = false
	player_remote.update_position = true
	Ui.show()
	
	$AudioStreamPlayer2D.stop()
	
	await get_tree().create_timer(1.0).timeout
	
	hide()
	
