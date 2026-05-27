extends Node2D

@export var Scene: PackedScene
var bot_input_array: Array[BotInputAction] = []
var delta_count = 0
var recording = false

func _physics_process(delta: float) -> void:
	delta_count += delta
	$Camera.position = $player.position + Vector2($player.speed * delta * 18 ,$player.velocity.y * delta * 18) 
	if !$player.is_on_floor():
		$Camera.zoom = $Camera.zoom.move_toward(Vector2(0.85, 0.85 ), delta / 3 * $player.velocity.y * -1 / $player.jump_strength)
		$Camera.zoom = clamp($Camera.zoom, Vector2(0.85, 0.85), Vector2(1.15, 1.15))
	
	$background_tilemap.position = $Camera.get_screen_center_position() / 2

func _ready() -> void:
	var next_level_position: Vector2 = Vector2(0, 416)
	var scene = Scene.instantiate()
	scene.position = next_level_position
	$rooms.add_child(scene)
	scene.checkpoint.connect(checkpoint)
	$finish_part.position = scene.next_room_position

func checkpoint():
	var macro = BotMacro.new()
	print($player.speed)
	bot_input_array = []
	recording = true
	delta_count = 0
	await $finish_part.checkpoint
	macro.input_chain = bot_input_array
	await get_tree().process_frame
	print(macro.input_chain)
	await get_tree().process_frame
	ResourceSaver.save(macro, "res://resources/export_macro.tres")
	print(bot_input_array)
	recording = false
func _input(event: InputEvent) -> void:
	if !recording: return
	if !InputMap.get_actions().any(event.is_action): return
	if event.is_echo(): return
	var event_action: StringName
	for i in InputMap.get_actions():
		if event.is_action(i): event_action = i
	print(event)
	bot_input_array.append(BotInputAction.new(BotInputAction.input_types.PRESS if event.is_pressed() else BotInputAction.input_types.RELEASE, event_action, delta_count))
