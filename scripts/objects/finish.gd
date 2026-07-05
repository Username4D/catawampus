extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.state = body.states.FINISHED
		if not body.is_in_group("bot"):
			body.finish()
