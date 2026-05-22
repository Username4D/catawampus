extends Node2D

func _physics_process(delta: float) -> void:
	$Camera.position = $player.position + $player.velocity * delta * 14 
	if !$player.is_on_floor():
		$Camera.zoom = $Camera.zoom.move_toward(Vector2(0.85, 0.85 ), delta / 3 * $player.velocity.y * -1 / $player.jump_strength)
		$Camera.zoom = clamp($Camera.zoom, Vector2(0.85, 0.85), Vector2(1.15, 1.15))
