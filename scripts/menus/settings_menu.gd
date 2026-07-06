extends Node2D

var sliders_ready = false

func _on_back_button_pressed() -> void:
	global_node_handler.view.animate_transition()
	await global_node_handler.view.transition_midpoint
	await get_tree().process_frame
	global_node_handler.view.change_scene(load("res://scenes/menus/main_menu.tscn"))
	global_node_handler.view.transition_continue.emit()

func _ready() -> void:
	$music_volume_slider.value = player_stats_handler.music_volume
	$sfx_volume_slider.value = player_stats_handler.sfx_volume
	await get_tree().process_frame
	sliders_ready = true

func _on_slider_changed(x) -> void:
	if !sliders_ready: return
	player_stats_handler.music_volume = $music_volume_slider.value
	player_stats_handler.sfx_volume = $sfx_volume_slider.value
