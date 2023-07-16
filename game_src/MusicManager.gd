extends Node

@onready var musicManager = $MusicStream
@onready var BallSpeed = $"../Ball"
@onready var BallSpeedClamp = 1.0
@onready var NumberIWant = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	NumberIWant = BallSpeed.linear_velocity.length()
	print(NumberIWant)
	BallSpeedClamp = (clamp(abs((NumberIWant)/200), 0.8, 1.2))
	print (BallSpeedClamp)
	musicManager.pitch_scale = BallSpeedClamp
	print (musicManager.pitch_scale)
	
	


