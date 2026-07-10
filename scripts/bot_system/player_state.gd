extends Resource

class_name PlayerState

@export var speed = 0
@export var has_accelerated = false
@export var jump_strength = 60
@export var position: Vector2 = Vector2.ZERO

func _init(speed = 0, has_accelerated = false, jump_strength = 0, position = Vector2.ZERO) -> void:
	self.speed = speed
	self.has_accelerated = has_accelerated
	self.jump_strength = jump_strength
	self.position = position
