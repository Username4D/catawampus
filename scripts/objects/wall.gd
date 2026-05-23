extends NinePatchRect

func _ready() -> void:
	print(self.size)
	$StaticBody2D/CollisionShape2D.shape.size = self.size
	print($StaticBody2D/CollisionShape2D.shape.size)
	$StaticBody2D/CollisionShape2D.position = self.size / 2
