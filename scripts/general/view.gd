extends Control

signal transition_midpoint
signal transition_continue

func animate_transition():
	var timer = get_tree().create_timer(0.5)
	$transition/AspectRatioContainer.visible = true
	while timer.time_left != 0:
		$transition/AspectRatioContainer/ColorRect.set_instance_shader_parameter('progress', 1 + timer.time_left * 2)
		await get_tree().process_frame
	$transition/AspectRatioContainer/ColorRect.set_instance_shader_parameter('progress', 1)
	transition_midpoint.emit()
	await transition_continue
	await get_tree().create_timer(0.4).timeout
	timer = get_tree().create_timer(0.5)
	while timer.time_left != 0:
		$transition/AspectRatioContainer/ColorRect.set_instance_shader_parameter('progress', 2 - timer.time_left * 2)
		await get_tree().process_frame
	$transition/AspectRatioContainer/ColorRect.set_instance_shader_parameter('progress', 2)
	$transition/AspectRatioContainer.visible = false


func _enter_tree() -> void:
	global_node_handler.view = self
	
func change_scene(new_scene: PackedScene):
	for i in $content.get_children():
		i.queue_free()
	$content.add_child(new_scene.instantiate())
