extends Area2D

var collected = false
@export var input_chains: Array[Resource]

signal checkpoint

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !collected and !body.is_in_group("bot"):
		body.checkpoint_collected.emit(self.global_position)
		$highlight_effect.color.a = 0.5
		checkpoint.emit()
		collected = true
	if body.is_in_group("player") and body.is_in_group("bot"):
		body.checkpoint_collected.emit(self.global_position, input_chains[randi_range(0, len(input_chains) - 1)].input_chain)
	
func _process(delta: float) -> void:
	$highlight_effect.color.a = move_toward($highlight_effect.color.a, 0, delta)
