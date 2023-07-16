extends Node

@onready var musicManager = $MusicStream
@onready var Ball = $"../Ball"
@onready var BallSpeedClamp = 1.0
@onready var NumberIWant = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Ball = get_parent().get_node("Ball")
	pass # Replace with function body.

func update_ball_ref(ball):
	Ball = ball

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Ball != null:
		NumberIWant = Ball.linear_velocity.length()

		BallSpeedClamp = (clamp(abs((NumberIWant)/200), 0.8, 1.2))

		musicManager.pitch_scale = BallSpeedClamp

	
	




func _on_go_button_pressed():
	$MusicStream.play()
	pass # Replace with function body.
