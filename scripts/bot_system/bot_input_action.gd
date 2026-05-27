extends Resource

class_name BotInputAction

enum input_types {PRESS, RELEASE}
@export var type: input_types
@export var action_name: String
@export var time_stamp: float

func _init(_init_type: input_types = input_types.PRESS, _init_action_name: String = "ui_up", _init_time_stamp: float = 0.1) -> void:
	if _init_type: type = _init_type
	if _init_action_name: action_name = _init_action_name
	if _init_time_stamp: time_stamp = _init_time_stamp
