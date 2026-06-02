extends Node2D

@export var level: PackedScene

func _ready() -> void:
	var next_level_position: Vector2 = Vector2(0, 416)
	var level_scene = level.instantiate()
	level_scene.position = next_level_position
	self.add_child(level_scene)
	await get_tree().process_frame
	next_level_position = level_scene.next_room_position
	$player.max_x = next_level_position.x
	var scene = load("res://scenes/rooms/end_part.tscn").instantiate()
	scene.position = next_level_position
	$rooms.add_child(scene)
	await get_tree().process_frame
	next_level_position = scene.next_room_position

func _physics_process(delta: float) -> void:
	$Camera.position = $player.position + Vector2($player.speed * delta * 18 ,$player.velocity.y * delta * 18) 
	if !$player.is_on_floor():
		$Camera.zoom = $Camera.zoom.move_toward(Vector2(0.85, 0.85 ), delta / 3 * $player.velocity.y * -1 / $player.jump_strength)
		$Camera.zoom = clamp($Camera.zoom, Vector2(0.85, 0.85), Vector2(1.15, 1.15))
	
	$background_tilemap.position = $Camera.get_screen_center_position() / 2
	
