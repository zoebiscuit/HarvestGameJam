extends Node2D
@onready var music: AudioStreamPlayer = $"../Music"
@onready var wind: AudioStreamPlayer = $"../Wind"


func _ready() -> void:
	
	# NOTE DO NOT FORGET TO TURN THIS BACK ON IF OFF!!!
	
	Ui.item_menu.can_open = false
	
	Ui.show()
	Ui.item_menu.can_open = true
	music.play()
	wind.play()


func _process(delta: float) -> void:
	pass
