extends Node2D

var sprite_0 = preload("res://assets/tiles/pixel_platformer/tile_0160.png")
var sprite_1 = preload("res://assets/tiles/pixel_platformer/tile_0161.png")
var sprite_2 = preload("res://assets/tiles/pixel_platformer/tile_0162.png")
var sprite_3 = preload("res://assets/tiles/pixel_platformer/tile_0163.png")
var sprite_4 = preload("res://assets/tiles/pixel_platformer/tile_0164.png")
var sprite_5 = preload("res://assets/tiles/pixel_platformer/tile_0165.png")
var sprite_6 = preload("res://assets/tiles/pixel_platformer/tile_0166.png")
var sprite_7 = preload("res://assets/tiles/pixel_platformer/tile_0167.png")
var sprite_8 = preload("res://assets/tiles/pixel_platformer/tile_0168.png")
var sprite_9 = preload("res://assets/tiles/pixel_platformer/tile_0169.png")

@onready var milliseconds_1 = get_node("Milliseconds1")
@onready var milliseconds_2 = get_node("Milliseconds2")
@onready var seconds_1 = get_node("Seconds1")
@onready var seconds_2 = get_node("Seconds2")
@onready var minutes_1 = get_node("Minutes1")
@onready var minutes_2 = get_node("Minutes2")
@onready var separator_1 = get_node("Separator1")
@onready var separator_2 = get_node("Separator2")

var time_elapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	minutes_1.visible = false
	minutes_2.visible = false
	separator_2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	
	var minutes = "%02d" % [time_elapsed / 60]
	var seconds = "%02d" % [fmod(time_elapsed, 60)]
	var milliseconds = "%02d" % [fmod(time_elapsed, 1) * 100]
	
	if (minutes != "00"):
		minutes_1.visible = true
		minutes_2.visible = true
		separator_2.visible = true
	
	_update_stopwatch_sprites(milliseconds, seconds, minutes)	
	

func _update_stopwatch_sprites(milliseconds, seconds, minutes):
	_update_sprite(milliseconds[0], milliseconds_2)
	_update_sprite(milliseconds[1], milliseconds_1)
	_update_sprite(seconds[0], seconds_2)
	_update_sprite(seconds[1], seconds_1)
	_update_sprite(minutes[0], minutes_2)
	_update_sprite(minutes[1], minutes_1)
	
func _update_sprite(number, node):
	match number:
		"0":
			node.set_texture(sprite_0)
		"1":
			node.set_texture(sprite_1)
		"2":
			node.set_texture(sprite_2)
		"3":
			node.set_texture(sprite_3)
		"4":
			node.set_texture(sprite_4)
		"5":
			node.set_texture(sprite_5)
		"6":
			node.set_texture(sprite_6)
		"7":
			node.set_texture(sprite_7)
		"8":
			node.set_texture(sprite_8)
		"9":
			node.set_texture(sprite_9)
		
