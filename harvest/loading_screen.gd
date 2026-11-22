extends Control
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

var progress : Array[float] = []

func _ready() -> void:
	ResourceLoader.load_threaded_request(Global.next_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var status = ResourceLoader.load_threaded_get_status(Global.next_scene, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var pct = progress[0] * 100
			progress_bar.value = pct
			
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(Global.next_scene)
			get_tree().change_scene_to_packed(scene)
