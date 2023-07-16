extends Node2D

const LOOP = preload("res://scenes/chain/loop.tscn")
const LINK = preload("res://scenes/chain/link.tscn")

@export var loops = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = $Anchor
	for i in range(loops):
		var child = add_loop(parent)
		add_link(parent, child)
		parent = child

func add_loop(parent):
	var loop = LOOP.instantiate()
	loop.position = parent.position
	loop.position.y += 36
	add_child(loop)
	return loop

func add_link(parent, child):
	var pin = LINK.instantiate()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
