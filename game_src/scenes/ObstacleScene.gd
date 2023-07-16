extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var obstacle_points: Array[Obstacle];
var collision_segments: Array;
var drawing_still_in_progress: bool = false;

func serialise():
	var serialisation_dictionary = {}
	serialisation_dictionary['type'] = 'obstacle_scene'
	serialisation_dictionary['points'] = obstacle_points.map(func (o: Obstacle): return o.coordinates_as_dict())
	return serialisation_dictionary
	
func _init():
	print('obstacle init')
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_points(obstacle_points: Array[Obstacle]) -> void:
	self.obstacle_points = obstacle_points
	var take_every = 5
	var p = []
	for i in len(self.obstacle_points) - take_every:
		if i % take_every == 0:
			var from = self.obstacle_points[i].from
			var to = self.obstacle_points[i + take_every].from
			p.append(Obstacle.new(from, to, self.obstacle_points[i].get_obstacle_type()))
#	var p = obstacle_points.map(func (p) )
	
	for op in p:		
		var collisionSegment = CollisionShape2D.new()
		var angle = op.from.angle_to(op.to);
		var diff = op.from - op.to
		var magnitude = diff.length()

		var size = Vector2(magnitude, 5)

		collisionSegment.shape = RectangleShape2D.new();
		collisionSegment.shape.size = size;
		collisionSegment.position = op.from
		collisionSegment.rotation = (op.from - op.to).angle()


#		collisionSegment.shape = SegmentShape2D.new();
#		collisionSegment.shape.a = op.from;
#		collisionSegment.shape.b = op.to;
		$StaticBody2D.add_child(collisionSegment)
	queue_redraw()

func clear_obstacles() -> void:
	self.obstacle_points = []
	for n in $StaticBody2D.get_children():
		$StaticBody2D.remove_child(n)
		n.queue_free()
	queue_redraw()

func set_drawing_still_in_progress(state: bool):
	drawing_still_in_progress = state;
	var space_state = get_world_2d().direct_space_state
	if (not drawing_still_in_progress and len(obstacle_points) and obstacle_points[0].get_obstacle_type() == Types.DRAWABLE_OBSTACLE_TYPES.STICKY):
		for obstacle in obstacle_points:
			var from = obstacle.from;
			var to = obstacle.to;
			var query = PhysicsRayQueryParameters2D.create(from, to)
			query.hit_from_inside = true
			var result = space_state.intersect_ray(query)
			if (result):
				print('reparenting')
#				print('reparenting to', result.collider)
				self.reparent(result.collider)
				return
		self.queue_free()
		
func _draw():
	for op in self.obstacle_points:
		var colour = Color.DARK_MAGENTA if op.get_obstacle_type() == Types.DRAWABLE_OBSTACLE_TYPES.STICKY else Color.DARK_GREEN;
		draw_line(op.from, op.to, colour, 10, true)
	pass
