extends Control

signal timer_finished

func _ready() -> void:
	$AnimationPlayer.play("timer")
	$AnimationPlayer.animation_finished.connect(func(_x): timer_finished.emit())
	$AnimationPlayer.animation_finished.connect(func(_x): self.visible = false)
	
