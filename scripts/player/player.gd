extends CharacterBody2D

var speed = 0
var max_speed = 500
var has_accelerated = false
var acceleration = 500
var friction = 800
@export var max_jump_strength = 400
@export var jump_strength = 60
var jump_strength_load_speed = 1000
var air_resistance = 100
var last_checkpoint_position = Vector2.ZERO

signal checkpoint_collected(pos: Vector2)
signal death

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			has_accelerated = true
			speed = move_toward(speed, max_speed, delta * acceleration)
			jump_strength = move_toward(jump_strength, max_jump_strength, delta * jump_strength_load_speed)
		else:
			if has_accelerated == false:
				speed = move_toward(speed, 0, friction * delta)
			else:
				velocity.y = -jump_strength
				jump_strength = 60
				has_accelerated = false
	elif velocity.y < 0:
		speed = move_toward(speed, 0, air_resistance * delta)
	elif speed > max_speed:
		speed = move_toward(speed, max_speed, air_resistance * delta * 7)
	velocity.x = speed
	velocity.y += get_gravity().y * delta
	move_and_slide()


func _on_death() -> void:
	await get_tree().create_timer(1).timeout
	self.position = last_checkpoint_position
	velocity = Vector2.ZERO
	speed = 0

func _on_checkpoint_collected(pos: Vector2) -> void:
	last_checkpoint_position = pos
