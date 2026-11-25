extends Control
@onready var ticker: Control = $Band/Ticker
@onready var ticker_area: Area2D = $Band/Ticker/Ticker
@onready var target: Control = $Band/Target
@onready var target_area: Area2D = $Band/Target/Target
@onready var animation: AnimatedSprite2D = $Graphic/Texture

# SOUND
@onready var accept: AudioStreamPlayer = $Accept
@onready var fail: AudioStreamPlayer = $Fail
@onready var click: AudioStreamPlayer = $Click

var tween : Tween
var gone : bool = false
var strikes : int = 3

signal drop_graded

func _ready() -> void:
	
	animation.play("default")
	Ui.show()
	Ui.item_menu.can_open = false # NOTEL turn this back on bro
	
	for option in Ui.item_menu.selection_wheel.options:
		if option.name == "Produce":
			
			var speed = 1.0 * option.count
			
			for trials in option.count: # for every produce there is one trial
				await trial(speed)
				await drop_graded
				speed -= 1.0
				
				option.count -= 1
				print(option.count)
			
			print(option.count)
			option.count = 0 # used them all
			
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if gone:
			return
		
		gone = true
		
		if tween:
			tween.kill() 
		
		await drop()

func trial(speed: float):
	
	if tween: tween.kill()
	
	random_target()
	ticker.global_position = Vector2(-80.0, 931.0)
	
	tween = create_tween().set_loops()
	tween.tween_property(ticker, "global_position", Vector2(1770.0, 931.0), speed)
	tween.tween_property(ticker, "global_position", Vector2(165.0, 931.0), speed)
	
	return

func drop(): # grading for placement!
	gone = false
	drop_graded.emit()
	
	if ticker_area.overlaps_area(target_area):
		accept.play()
		Ui.add_support(5)
		animation.play("success")
		
	else: 
		fail.play()
		
		Ui.lose_confidence(10)
		Ui.lose_support(5)
		animation.play("fail")
		
		
		pass # fail, support and confidence loss, dont do nothing yet

func random_target():
	var random_x = randi_range(124, 1660)
	target.position = Vector2(float(random_x), 932.0)
	
