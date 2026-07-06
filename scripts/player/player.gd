extends CharacterBody2D

@export var speed = 0
var max_speed = 700
var has_accelerated = false
var acceleration = 500
var friction = 800
@export var max_jump_strength = 450
@export var jump_strength = 60
var jump_strength_load_speed = 6000
var air_resistance = 100
var last_checkpoint_position = Vector2.ZERO
@export var state = states.ALIVE

@export var max_x = 0
@export var progress = 0
enum states {ALIVE, DEAD, FINISHED, NOTSTARTED}
signal checkpoint_collected(pos: Vector2)
signal death

@export var zoom = Vector2.ONE
@export var ui_leaderboard = []

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	$cat_image.skew = velocity.y / 1000 
	if state == states.ALIVE:
		progress = clamp(position.x / max_x / 0.01, 0, 100)
		if is_on_floor():
			if Input.is_action_pressed("ui_accept"):
				has_accelerated = true
				if speed < max_speed:
					speed = move_toward(speed, max_speed, delta * acceleration)
				else:
					speed = move_toward(speed, max_speed, delta * acceleration * 0.25)
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
			speed = move_toward(speed, max_speed, air_resistance * delta * 5)
		velocity.x = speed
		velocity.y += get_gravity().y * delta
		move_and_slide()
	elif state == states.FINISHED or state == states.NOTSTARTED:
		if is_on_floor():
			speed = move_toward(speed, 0, friction * delta)
		elif velocity.y < 0:
			speed = move_toward(speed, 0, air_resistance * delta)
		elif speed > max_speed:
			speed = move_toward(speed, max_speed, air_resistance * delta * 5)
		velocity.x = speed
		velocity.y += get_gravity().y * delta
		move_and_slide()

func _on_death() -> void:
	state = states.DEAD
	await get_tree().create_timer(1).timeout
	self.position = last_checkpoint_position
	velocity = Vector2.ZERO
	jump_strength = 60
	has_accelerated = false
	speed = 0
	state = states.ALIVE

func _on_checkpoint_collected(pos: Vector2) -> void:
	last_checkpoint_position = pos
	print([self.acceleration, speed, jump_strength, has_accelerated]) 

func finish():
	$ui.show_winscreen()
	
