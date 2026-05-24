extends Node2D

@export var next_room_position := Vector2.ZERO

func _ready() -> void:
	next_room_position = $end.global_position
