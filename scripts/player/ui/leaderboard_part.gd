extends Control

@export var is_highlighted: bool = false
@export var text: String = ""

func _ready() -> void:
	$Label.text = text
	$player_highlight.visible = is_highlighted
