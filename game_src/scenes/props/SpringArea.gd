extends Area2D
var spring_force: int = 1000;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(body.name)
	if body.name == "Ball":
		$AnimationPlayer.play("active")
		if (get_parent().get_spring_state() == Types.PROP_INTERACTION_STATE.PLACED):
			var velocity: Vector2 = body.linear_velocity;
			var magnitude = velocity.length()
			var normal = get_parent().normal;
			var impulse = -spring_force * velocity.dot(normal) * normal;
			impulse = normal * spring_force;
			body.hit_spring(impulse)

func _on_body_exited(body):
	if body.name == "Ball":
		$AnimationPlayer.play("RESET")

func set_spring_force(force: int): 
	spring_force = force;
