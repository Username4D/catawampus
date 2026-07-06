extends Node2D

var gp_scene = preload('res://scenes/gameplay/gameplay_scene.tscn')

var skin_prices = [0, 20, 50, 80, 125, 175, 250, 9999]

func _on_play_button_pressed() -> void:
	global_node_handler.view.show_accent = true
	self.get_parent().call_deferred('add_child', gp_scene.instantiate())
	self.queue_free()



func _on_skins_button_pressed() -> void:
	while !$menu_items.offset.y <= -648:
		$menu_items.offset.y -= get_process_delta_time() * 1600
		await get_tree().process_frame
	
func _process(delta: float) -> void:
	$cat_image.skin_index = player_stats_handler.player_skin
	$menu_items/skin_controller/trophies_label.text = "%d Trophies" % player_stats_handler.player_trophies
	
	if player_stats_handler.player_trophies < skin_prices[player_stats_handler.player_skin + 1] and player_stats_handler.player_skin != 6:
		$menu_items/skin_controller/requirement_label.visible = true
		$menu_items/skin_controller/next.visible = true
		$menu_items/skin_controller/requirement_label.text = "%d Trophies required" % skin_prices[player_stats_handler.player_skin + 1]
	elif player_stats_handler.player_skin == 6:
		$menu_items/skin_controller/requirement_label.visible = false
		$menu_items/skin_controller/next.visible = false
	else:
		$menu_items/skin_controller/requirement_label.visible = false
		$menu_items/skin_controller/next.visible = true
	$menu_items/skin_controller/prev.visible = !player_stats_handler.player_skin == 0

func _on_next_pressed() -> void:
	if not player_stats_handler.player_trophies < skin_prices[player_stats_handler.player_skin + 1] and player_stats_handler.player_skin != 6:
		player_stats_handler.player_skin += 1

func _on_prev_pressed() -> void:
	if player_stats_handler.player_skin != 0:
		player_stats_handler.player_skin -= 1


func _on_back_pressed() -> void:
	while !$menu_items.offset.y >= 0:
		$menu_items.offset.y = move_toward($menu_items.offset.y, 0, get_process_delta_time() * 1600)
		await get_tree().process_frame
