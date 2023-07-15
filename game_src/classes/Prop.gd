extends Node2D
class_name Prop
@export var interaction_state: Types.PROP_INTERACTION_STATE;

func set_interaction_state(new_state: Types.PROP_INTERACTION_STATE):
	interaction_state = new_state;

func get_interaction_state() -> Types.PROP_INTERACTION_STATE:
	return interaction_state;

func _init():
	self.interaction_state = Types.PROP_INTERACTION_STATE.INACTIVE
	print('Prop class initialised')

#class Prop:
#	var interaction_state:
#		set(new_value):
#			interaction_state = new_value
#		get:
#			return interaction_state
#
#	func _init():
#		print('Prop class initialised')
