extends AnimatableBody2D

@export var velocity = 0
@export var height = 0
@export var linked_trampoline: Node

signal collision(player: Node)

var current_player: Node
@onready var cooldown = Timer.new()

func _physics_process(delta: float) -> void:
	if $player_detector.get_overlapping_bodies() != []:
		for i in $player_detector.get_overlapping_bodies():
			if i.is_in_group("player") and velocity == 0 and height == 0:
				if linked_trampoline != null:
					linked_trampoline.collision.emit(i)
					print("wow")
				else:
					if cooldown.time_left == 0:
						velocity = 200
						current_player = i
						print("wow")
			
	if linked_trampoline == null:
		if velocity != 0 or height != 0:
			height += delta * velocity
			height = clamp(height, 0, 32)
			$sprite_pad.position.y = height
			$sprite_spring.scale.y = 1 - 0.6 * height / 24
			velocity -= delta * 600 if velocity <  0 else delta * 1200
			$CollisionShape2D.position.y = -14 + height
			if height == 0:
				velocity = 0
				current_player.velocity.y += -600
				cooldown.start()
	else:
		height = linked_trampoline.height
		velocity = linked_trampoline.velocity
		$sprite_pad.position.y = height
		$sprite_spring.scale.y = 1 - 0.6 * height / 24
		$CollisionShape2D.position.y = -14 + height

func _ready() -> void:
	self.add_child(cooldown)
	cooldown.wait_time = 0.1
	cooldown.one_shot = true
	collision.connect(collide)

func collide(player):
	if linked_trampoline != null:
		linked_trampoline.collision.emit(player)
	else:
		if cooldown.time_left == 0:
			current_player = player
			velocity = 200
			print("wow")
