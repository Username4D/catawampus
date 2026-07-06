extends Control

signal transition_midpoint
signal transition_continue

var accent_volume = 1
var show_accent = false

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

func _ready() -> void:
	var timer = get_tree().create_timer(1)
	while timer.time_left != 0:
		$audio_track_accent.volume_linear = 1 - timer.time_left
		$audio_track_base.volume_linear = 1 - timer.time_left
		await get_tree().process_frame

func _process(delta: float) -> void:
	AudioServer.set_bus_volume_linear(1, float(player_stats_handler.music_volume) / 10)
	AudioServer.set_bus_volume_linear(4, float(player_stats_handler.sfx_volume) / 10)
	AudioServer.set_bus_volume_linear(3, move_toward(AudioServer.get_bus_volume_linear(3), accent_volume if show_accent else 0, delta))
