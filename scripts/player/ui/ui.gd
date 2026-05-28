extends CanvasLayer 

func _process(delta: float) -> void:
	$level_progress.value = clamp(self.get_parent().position.x / self.get_parent().max_x / 0.01, 0, 100)
	$level_progress/percentage_label.text = str(int($level_progress.value)) + "%"
