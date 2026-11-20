@tool #runs in editor first
extends Control

@onready var count: Label = $Count
@onready var highlight_sfx: AudioStreamPlayer2D = $HighlightSFX

const SPRITE_SIZE = Vector2(128,128)

#gathering variables to edit
@export var bkg_color: Color
@export var line_color: Color
@export var outer_radius: int = 256
@export var inner_radius: int = 64
@export var line_width: int = 4
@export var highlight_color : Color

@export var options: Array[WheelOption]

var select = 0
var last_select: int = -1

var can_open := true

func _draw():
	
	var offset = SPRITE_SIZE / -2
	
	
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	
	if len(options) >= 3:
		for i in range(len(options)-1):
			var rads= TAU * i /((len(options)-1))
			var point = Vector2.from_angle(rads)
			draw_line(
				point*inner_radius,
				point*outer_radius,
				line_color,
				line_width,
				true
			)
			
		#if select == 0:
			#draw_circle(Vector2.ZERO, inner_radius, highlight_color)
			#
		
		draw_texture_rect_region(
			options[0].atlas,
			Rect2(offset, SPRITE_SIZE),
			options[0].region
		)
		
		for i in range(1, len(options)):
			var start_rads = (TAU * (i-1)/ (len(options)-1))
			var end_rads = (TAU*i) / (len(options)-1)
			var mid_rads = (start_rads + end_rads)/2.0 * -1
			var radius_mid = (inner_radius + outer_radius)/2
			
			if select == i:
				var points_per_arc = 32
				var points_inner = PackedVector2Array()
				var points_outer = PackedVector2Array()
				
				for j in range(points_per_arc+1):
					var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
					points_inner.append(inner_radius * Vector2.from_angle(TAU-angle))
					points_outer.append(outer_radius * Vector2.from_angle(TAU-angle))
					
				points_outer.reverse()
				draw_polygon(
					points_inner + points_outer,
					PackedColorArray([highlight_color])
				)
				
				
			var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
			draw_texture_rect_region(
				options[i].atlas,
				Rect2(draw_pos, SPRITE_SIZE),
				options[i].region
			)

var highlight_sfx_played = false

func _process(delta):
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()
	
	if InputMap.has_action("menu"):
		if Input.is_action_pressed("menu") and can_open:
			show()
		elif Input.is_action_just_released("menu"):
			hide()
		else:
			hide()
	
	
	if mouse_radius > outer_radius:
		select = 0
		highlight_sfx_played = false
		
		if is_instance_valid(highlight_sfx):
			highlight_sfx.stop()
	
	
	else:
		var mouse_rads = fposmod(mouse_pos.angle()* -1, TAU)
		select = ceil((mouse_rads/TAU)*(len(options)-1)) #ceil = round up (integer wise)
	
	if select != last_select:
		last_select = select
		queue_redraw()

		if select > 0 and select < len(options) and options[select] != null:
			if is_instance_valid(count):
				count.text = str(options[select].count)
			if is_instance_valid(highlight_sfx):
				highlight_sfx.stop() 
				highlight_sfx.play()
		else:
			if is_instance_valid(count):
				count.text = ""
		
	queue_redraw()
