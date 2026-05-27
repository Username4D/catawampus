extends NinePatchRect

func _ready() -> void:  
	$StaticBody2D/CollisionShape2D.shape.size = self.size
	$StaticBody2D/CollisionShape2D.position = self.size / 2
