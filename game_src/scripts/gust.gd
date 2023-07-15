extends Area2D

var default_gravity = Vector2(0,-1)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gravity_direction = default_gravity.rotated(rotation)
#	print(basis)
