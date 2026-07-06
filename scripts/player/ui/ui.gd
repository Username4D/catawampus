extends CanvasLayer 

var leaderboard_part_scene = preload("res://scenes/player/ui/leaderboard_part.tscn")

func _process(delta: float) -> void:
	%level_progress.value = clamp(self.get_parent().position.x / self.get_parent().max_x / 0.01, 0, 100)
	%level_progress/percentage_label.text = str(int(%level_progress.value)) + "%"
	
	$zoom_layer.scale = self.get_parent().zoom
	for i in %leaderboard.get_children():
		i.position.y = move_toward(i.position.y, self.get_parent().ui_leaderboard.find(i.object) * 40, delta * 250)
func _ready() -> void:
	await get_tree().process_frame
	for i in range(0, len(self.get_parent().ui_leaderboard) ):
		var new = leaderboard_part_scene.instantiate()
		new.name = self.get_parent().ui_leaderboard[i].name
		new.position.y = i * 40
		new.object = self.get_parent().ui_leaderboard[i]
		if new.object.is_in_group("bot"): new.is_highlighted = false
		new.text = new.name
		%leaderboard.add_child(new)

func show_winscreen():
	await get_tree().create_timer(1).timeout
	$zoom_layer/win_screen.lb_position = self.get_parent().ui_leaderboard.find(self.get_parent()) + 1
	$zoom_layer/leaderboard.position = Vector2(456, 208)
	$zoom_layer/win_screen.visible = true
	$zoom_layer/level_progress.visible = false
	$zoom_layer/pause_button.visible = false
	

func _on_pause_button_pressed() -> void:
	$pause_menu.visible = true
	self.get_parent().get_parent().process_mode = Node.PROCESS_MODE_DISABLED
