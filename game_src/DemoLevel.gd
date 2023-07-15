extends Node2D

enum DRAWING_STATE {
	RELEASED,
	DRAWING,
	PROP_PLACEMENT
}
var obstacle_scene = load("res://scenes/ObstacleScene.tscn");
var state: DRAWING_STATE = DRAWING_STATE.RELEASED;
var obstacle_points: Array[Obstacle];
var obstacle_scenes: Array = []; # Array of ObstacleScenes
var from: Vector2;
var to: Vector2;
var prop_is_being_placed: bool = false;
var current_obstacle_scene;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
#	var props = get_tree().get_nodes_in_group("Props")
#	var prop_is_being_placed = false
#	if (len(props)):
#		prop_is_being_placed = props.any(func (p): return p.get_interaction_state() == Types.PROP_INTERACTION_STATE.PLACING);		

#	if event is InputEventMouseButton and not (prop_is_being_placed or state == DRAWING_STATE.PROP_PLACEMENT):
	if event is InputEventMouseButton and not (state == DRAWING_STATE.PROP_PLACEMENT):
		print(event)
		if (event.pressed):
			current_obstacle_scene = obstacle_scene.instantiate()
			add_child(current_obstacle_scene)
			state = DRAWING_STATE.DRAWING
			from = event.position;
			from =  get_local_mouse_position()
		elif (not event.pressed):
			print('released')
			state = DRAWING_STATE.RELEASED
			to = event.position;
			to =  get_local_mouse_position()
			var ob = Obstacle.new(from, to, Types.DRAWABLE_OBSTACLE_TYPES.NORMAL);
			obstacle_points.append(ob);
			current_obstacle_scene.set_points(obstacle_points)
			obstacle_points=[]
			current_obstacle_scene = null;
			
	elif event is InputEventMouseMotion:
		if (state == DRAWING_STATE.RELEASED):
			pass
#			print('do nothing')
		elif  (state == DRAWING_STATE.DRAWING):
			if (not current_obstacle_scene):
				return
			to = event.position;
			to =  get_local_mouse_position()
			var ob = Obstacle.new(from, to, Types.DRAWABLE_OBSTACLE_TYPES.NORMAL)
			obstacle_points.append(ob);
			from = to;
			current_obstacle_scene.set_points(obstacle_points)
			
func _on_button_pressed():
	get_tree().paused = true
	pass # Replace with function body.


func _on_resume_pressed():
	print('pressed')
	get_tree().paused = false
	pass # Replace with function body.
