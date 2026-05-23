extends Area2D

var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !collected:
		body.checkpoint_collected.emit(self.position)
		$highlight_effect.color.a = 0.5
		collected = true

func _process(delta: float) -> void:
	$highlight_effect.color.a = move_toward($highlight_effect.color.a, 0, delta)
