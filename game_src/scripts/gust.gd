extends Prop 

var normal: Vector2 = Vector2(0,-1);
var in_valid_position: bool = false;
var colliding_body: Node2D
var global_coords: Vector2;
#signal spring_being_placed
#signal spring_placed

func _input(event):		

	if (self.interaction_state == Types.PROP_INTERACTION_STATE.PLACING):
		global_position = get_global_mouse_position()
		for raycast in $RayCasts.get_children():
			if raycast.is_colliding() and self.interaction_state == Types.PROP_INTERACTION_STATE.PLACING:
				normal = raycast.get_collision_normal()
				rotation = normal.angle() + PI/2
				in_valid_position = true
				colliding_body = raycast.get_collider()
				self.global_coords = global_position
				break
			elif self.interaction_state == Types.PROP_INTERACTION_STATE.PLACING:
				in_valid_position = false
		if event is InputEventMouseButton:
			if not event.pressed:
				if (in_valid_position):
					set_interaction_state(Types.PROP_INTERACTION_STATE.PLACED)
#					spring_placed.emit()

func set_interaction_state(state: Types.PROP_INTERACTION_STATE):
	super.set_interaction_state(state);
	if (state == Types.PROP_INTERACTION_STATE.PLACING):
		$GustArea/PipeSprite.modulate.a = 0.5
	elif (state == Types.PROP_INTERACTION_STATE.PLACED):
		self.reparent(colliding_body)
		$GustArea/PipeSprite.modulate.a = 1
#var default_gravity = Vector2(0,-1)
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	gravity_direction = default_gravity.rotated(rotation)
##	print(basis)
