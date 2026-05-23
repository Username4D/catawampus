extends Area2D

var rotation_speed = 0.5

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.death.emit()

func _process(delta: float) -> void:
	$texture.rotation += delta * PI * rotation_speed
