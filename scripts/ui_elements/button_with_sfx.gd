extends Button

class_name SfxButton

func _ready() -> void:
	pressed.connect(func(): global_node_handler.audio.play_sfx("click.wav"))
	mouse_entered.connect(func(): global_node_handler.audio.play_sfx("hover.wav"))
