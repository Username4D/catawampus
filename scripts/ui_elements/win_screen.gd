extends Control

@export var lb_position: int = 1
var trophy_gains = [8, 5, 3, 3, 1, 0, 0, 0, 0, 0, 0]


func _process(delta: float) -> void:
	$Label.text = str(lb_position) + right_ending(lb_position) + ' Place!'
	$trophy_label.text = "+ %d Trophies" % trophy_gains[lb_position - 1]

func _on_button_pressed() -> void:
	player_stats_handler.player_trophies += trophy_gains[lb_position - 1]
	player_stats_handler.save()
	global_node_handler.view.animate_transition()
	global_node_handler.view.show_accent = false
	await global_node_handler.view.transition_midpoint
	await get_tree().process_frame
	global_node_handler.view.change_scene(load("res://scenes/menus/main_menu.tscn"))
	global_node_handler.view.transition_continue.emit()

func right_ending(no: int) -> String:
	if no == 1: return 'st'
	elif no == 2: return 'nd'
	elif no == 3: return 'rd'
	else: return 'th'
