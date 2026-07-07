extends Control

signal timer_finished

func _ready() -> void:
	$AnimationPlayer.play("timer")
	$AudioStreamPlayer.play()
	$AnimationPlayer.animation_finished.connect(func(_x): timer_finished.emit())
	$AnimationPlayer.animation_finished.connect(func(_x): self.visible = false)
	
