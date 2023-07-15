extends Control

var spring_scene = load("res://scenes/props/spring.tscn");
var spring_scenes = []
var current_spring_scene = null;

signal spring_being_placed
signal spring_placed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if (event.pressed):
			var new_spring_scene = spring_scene.instantiate()
#			new_spring_scene.set_interaction_state(0)
			current_spring_scene = new_spring_scene;
			get_tree().get_root().add_child(new_spring_scene)
			new_spring_scene.set_interaction_state(Types.PROP_INTERACTION_STATE.PLACING)
			spring_being_placed.emit()



func _on_mouse_entered():
	set_default_cursor_shape(Control.CURSOR_POINTING_HAND  )
	pass # Replace with function body.
