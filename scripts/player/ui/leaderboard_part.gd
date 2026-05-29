extends Control

@export var is_highlighted: bool = false
@export var text: String = ""

func _ready() -> void:
	$Label.text = text
	$player_highlight.visible = is_highlighted
	if !is_highlighted: $fill.size.x = 224.0 - 16.0
	if !is_highlighted: $fill.position.x = 16.0
