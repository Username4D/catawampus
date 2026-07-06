extends Sprite2D

class_name catImage

@export var skins: Array[CompressedTexture2D]
@export var use_random: bool = false
@export var skin_index: int = 0

func _process(delta: float) -> void:
	if use_random:
		skin_index = randi_range(0, len(skins) - 1)
	self.texture = skins[skin_index]
