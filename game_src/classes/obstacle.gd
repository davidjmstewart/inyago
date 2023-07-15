#extends Serialisable
extends Node2D
class_name Obstacle
var from: Vector2;
var to: Vector2;
var obstacle_type: Types.DRAWABLE_OBSTACLE_TYPES;

func _init(from: Vector2, to: Vector2, type: Types.DRAWABLE_OBSTACLE_TYPES ):
	self.from = from;
	self.to = to;
	self.obstacle_type = type;

func coordinates_as_dict():
	var d = {
		"from": {
			"x": from.x,
			"y": from.y
		},
		"to": {
			"x": to.x,
			"y": to.y
		}
	}
	return d
	
func get_obstacle_type() -> Types.DRAWABLE_OBSTACLE_TYPES:
	return self.obstacle_type
