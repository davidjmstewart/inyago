extends Prop

var normal: Vector2 = Vector2(0,-1);
var in_valid_position: bool = false;
var colliding_body: Node2D
var global_coords: Vector2;
signal spring_being_placed
signal spring_placed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_coords = self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
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
					spring_placed.emit()

func set_interaction_state(state: Types.PROP_INTERACTION_STATE):
	super.set_interaction_state(state);
	if (state == Types.PROP_INTERACTION_STATE.PLACING):
		$SpringArea/SpringSprite.modulate.a = 0.5
	elif (state == Types.PROP_INTERACTION_STATE.PLACED):
		self.reparent(colliding_body)
		$SpringArea/SpringSprite.modulate.a = 1

func get_spring_state() -> Types.PROP_INTERACTION_STATE:
	return self.interaction_state
	
func get_is_in_valid_position() -> bool:
	return in_valid_position;


func serialise():
	var serialisation_dictionary = {}
	serialisation_dictionary['type'] = 'prop'
	serialisation_dictionary['prop_type'] = 'spring'
	serialisation_dictionary['normal_vector'] = {
		'x': normal.x,
		'y': normal.y
	}
	serialisation_dictionary['global_coords'] = {
		'x': global_coords.x,
		'y': global_coords.y
	}
	
	return serialisation_dictionary
