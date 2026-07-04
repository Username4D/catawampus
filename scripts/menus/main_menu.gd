extends Node2D

var gp_scene = preload('res://scenes/gameplay/gameplay_scene.tscn')

func _on_play_button_pressed() -> void:
	self.get_parent().call_deferred('add_child', gp_scene.instantiate())
	self.queue_free()
