extends Node2D

enum DRAWING_STATE {
	RELEASED,
	DRAWING,
	PROP_PLACEMENT
}

var obstacle_scene = load("res://scenes/ObstacleScene.tscn");
var state: DRAWING_STATE = DRAWING_STATE.RELEASED;
var current_drawing_type: Types.DRAWABLE_OBSTACLE_TYPES = Types.DRAWABLE_OBSTACLE_TYPES.NORMAL;

var obstacle_points: Array[Obstacle];
var obstacle_scenes: Array = []; # Array of ObstacleScenes
var from: Vector2;
var to: Vector2;
var prop_is_being_placed: bool = false;
var current_obstacle_scene;
var invalid_drawing_start_location = false;

var ballScene = preload("res://scenes/ball.tscn")
var initialBallPosition: Vector2 = Vector2.ZERO
var currentBallRef = null

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_tree().paused = true
	#$Ball/Camera2D.enabled = false
	currentBallRef = get_node("Ball") as RigidBody2D
	currentBallRef.get_node("Camera2D").enabled = false
	initialBallPosition = currentBallRef.position
	get_node("MusicManager")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	var props = get_tree().get_nodes_in_group("Prop")
	var prop_is_being_placed = false
	if (len(props)):
		prop_is_being_placed = props.any(func (p): return p.get_interaction_state() == Types.PROP_INTERACTION_STATE.PLACING);		

	if (prop_is_being_placed or invalid_drawing_start_location):
		return
	if event is InputEventMouseButton and not (prop_is_being_placed or state == DRAWING_STATE.PROP_PLACEMENT):
#	if event is InputEventMouseButton and not (state == DRAWING_STATE.PROP_PLACEMENT):

		if (event.pressed):
			current_obstacle_scene = obstacle_scene.instantiate()
			add_child(current_obstacle_scene)
			state = DRAWING_STATE.DRAWING
			from = event.position;
			from =  get_local_mouse_position()
		elif (not event.pressed):
			if (len(obstacle_points)):
				print('released')
				state = DRAWING_STATE.RELEASED
				to = event.position;
				to =  get_local_mouse_position()
				var ob = Obstacle.new(from, to, current_drawing_type);
				obstacle_points.append(ob);
				current_obstacle_scene.set_points(obstacle_points)
				current_obstacle_scene.set_drawing_still_in_progress(false)
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
			var ob = Obstacle.new(from, to, current_drawing_type)
			obstacle_points.append(ob);
			from = to;
			current_obstacle_scene.set_points(obstacle_points)
			
func _on_button_pressed():
	get_tree().paused = true

func _on_resume_pressed():
	get_tree().paused = false

func _on_clear_pressed():
	if (currentBallRef != null):
		currentBallRef.queue_free()
		get_parent().remove_child(currentBallRef)
	get_tree().reload_current_scene()

func _on_reset_pressed():
	if (currentBallRef != null):
		currentBallRef.queue_free()
		get_parent().remove_child(currentBallRef)
	var newBall = ballScene.instantiate()
	newBall.position = initialBallPosition
	currentBallRef = newBall
	get_node("MusicManager").update_ball_ref(newBall)
	get_parent().add_child(newBall)
#	newBall.get_node("Camera2D").enabled = true;
	$ObjectiveArea/Camera2D.enabled = false;
	$GameControls.visible = true

func _on_go_button_pressed():
	get_tree().paused = false
	currentBallRef.freeze = false;
	currentBallRef.get_node("Camera2D").enabled = true
	$GameControls.visible = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			_on_reset_pressed()

func _on_spring_placement_control_mouse_entered():
	invalid_drawing_start_location = true

func _on_spring_placement_control_mouse_exited():
	invalid_drawing_start_location = false

func _on_normal_pencil_control_normal_pencil_clicked():
	current_drawing_type = Types.DRAWABLE_OBSTACLE_TYPES.NORMAL
	var invalid_drawing_start_location = false;
	state = DRAWING_STATE.RELEASED;

func _on_game_controls_mouse_entered():
	invalid_drawing_start_location = true

func _on_game_controls_mouse_exited():
	invalid_drawing_start_location = false

func _on_sticky_pencil_control_sticky_pencil_clicked():
	current_drawing_type = Types.DRAWABLE_OBSTACLE_TYPES.STICKY
	pass # Replace with function body.


func _on_objective_area_body_entered(body):
	print('game over')
	get_tree().paused = true
	currentBallRef.get_node('Camera2D').zoom = Vector2(6,6);
#	$Ball.freeze = true;
#	$Ball/Camera2D.zoom = Vector2(2,2)
	currentBallRef.queue_free()
	get_parent().remove_child(currentBallRef)
	pass # Replace with function body.


func _on_reset_mouse_entered():
	invalid_drawing_start_location = true
	pass # Replace with function body.


func _on_reset_mouse_exited():
	invalid_drawing_start_location = false
	pass # Replace with function body.
