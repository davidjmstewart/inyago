extends Control

var gust_scene = load("res://scenes/gust.tscn");
var spring_scenes = []
var current_gust_scene = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if (event.pressed):
			var new_gust_scene = gust_scene.instantiate()
#			new_spring_scene.set_interaction_state(0)
			current_gust_scene = new_gust_scene;
			get_tree().get_root().add_child(new_gust_scene)
			new_gust_scene.set_interaction_state(Types.PROP_INTERACTION_STATE.PLACING)
#			spring_being_placed.emit()
