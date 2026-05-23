extends NinePatchRect

var progress = 0
var direction = 0
var max_progress = 10
var speed = 160

func _physics_process(delta: float) -> void:
	progress = move_toward(progress, 0 if direction == 1 else max_progress, delta * speed)
	if progress == (0 if direction == 1 else max_progress):
		direction = 0 if direction == 1 else 1
	$saw.position.y = progress + 32

func _ready() -> void:
	max_progress = self.size.y - 128
