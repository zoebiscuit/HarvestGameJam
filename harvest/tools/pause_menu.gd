extends CanvasLayer
@onready var music: AudioStreamPlayer = $AudioStreamPlayer

var can_open : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if can_open:
		if event.is_action_pressed("Pause") and not visible:
			open()
		elif event.is_action_pressed("Pause") and visible:
			if Settings.visible: Settings.close()
			else: close()
	else: hide()
		
func close():
	music.stop()
	toggle_pause()
	hide()

func open():
	music.play()
	toggle_pause()
	show()
	
func toggle_pause() -> void:
	var new_pause_state := not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_continue_pressed() -> void:
	close()


func _on_settings_pressed() -> void:
	Settings.open()


func _on_exit_pressed() -> void:
	get_tree().quit()
