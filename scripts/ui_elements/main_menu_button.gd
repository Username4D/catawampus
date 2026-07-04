extends Button

@export var label_text: String

func _ready() -> void:
	$Label.text = label_text
