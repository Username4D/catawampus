extends Area2D

func _physics_process(delta: float) -> void:
	for i in self.get_overlapping_bodies():
		if i.is_in_group("player"):
			if Input.is_action_just_pressed("ui_accept"):
				i.speed += 600
