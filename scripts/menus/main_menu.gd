extends Node2D

var gp_scene = preload('res://scenes/gameplay/gameplay_scene.tscn')

func _on_play_button_pressed() -> void:
	global_node_handler.view.show_accent = true
	self.get_parent().call_deferred('add_child', gp_scene.instantiate())
	self.queue_free()
