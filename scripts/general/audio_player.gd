extends Node

var files = {
	"click.wav" = preload("res://assets/audio/sfx/click.wav"),
	"hover.wav" = preload("res://assets/audio/sfx/hover.wav"),
	"jumps.wav" = preload("res://assets/audio/sfx/jumps.wav"),
	"land.wav" = preload("res://assets/audio/sfx/land.wav"),
	"dash.wav" = preload("res://assets/audio/sfx/dash.wav")
}

func play_sfx(sfx_name: String = ""):
	var player = AudioStreamPlayer.new()
	player.stream = files[sfx_name]
	player.bus = "sfx"
	self.add_child(player)
	player.play()
	await player.finished
	player.queue_free()

func _enter_tree() -> void:
	global_node_handler.audio = self
