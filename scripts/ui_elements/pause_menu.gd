extends Control

func _on_continue_pressed() -> void:
	self.get_parent().get_parent().get_parent().process_mode = Node.PROCESS_MODE_INHERIT
	self.visible = false

func _on_menu_pressed() -> void:
	global_node_handler.view.animate_transition()
	global_node_handler.view.show_accent = false
	await global_node_handler.view.transition_midpoint
	await get_tree().process_frame
	global_node_handler.view.change_scene(load("res://scenes/menus/main_menu.tscn"))
	global_node_handler.view.transition_continue.emit()
