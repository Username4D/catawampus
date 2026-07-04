extends Node2D

const level_amount = 10

var bot_names = ["Rando1000", "Wow", "x_1999", "hunter_x", "der Bomber", "turkey gAmer", "Rando1000", "Wow", "x_1999", "hunter_x", "der Bomber", "turkey gAmer"]
@onready var leader_board = $bots.get_children() + [$player]
var state = 'intro' # intro, gameplay, finished

func _physics_process(delta: float) -> void:
	$Camera.position = $player.global_position + Vector2($player.speed * delta * 18 ,$player.velocity.y * delta * 18) 
	$background_tilemap.position = $Camera.get_screen_center_position() / 2
	if state == 'gameplay':
		if !$player.is_on_floor():
			$Camera.zoom = $Camera.zoom.move_toward(Vector2(0.85, 0.85 ), delta / 3 * $player.velocity.y * -1 / $player.jump_strength)
			$Camera.zoom = clamp($Camera.zoom, Vector2(0.85, 0.85), Vector2(1.15, 1.15))
	if state == 'intro':
		$player.zoom = $player.zoom.move_toward(Vector2.ONE, delta * 2)
		$Camera.zoom = $Camera.zoom.move_toward(Vector2.ONE, delta)
		pass
	

func _ready() -> void:
	$bots.process_mode = Node.PROCESS_MODE_DISABLED
	$Camera.make_current()
	$player.zoom = Vector2(2, 2)
	%timer.timer_finished.connect(timer_timeout)
	for i in $bots.get_children():
		var new_name = bot_names[randi_range(0, len(bot_names) - 1  )]
		i.name = new_name
		bot_names.erase(new_name)
	update_leader_board()
	var next_level_position: Vector2 = Vector2(0, 416)
	for i in range(0, 5):
		var scene = load("res://scenes/rooms/individual_rooms/%d.tscn" % randi_range(1, level_amount)).instantiate()
		scene.position = next_level_position
		$rooms.add_child(scene)
		await get_tree().process_frame
		next_level_position = scene.next_room_position
	$player.max_x = next_level_position.x
	for i in $bots.get_children():
		i.max_x = next_level_position.x
	var scene = load("res://scenes/rooms/end_part.tscn").instantiate()
	scene.position = next_level_position
	$rooms.add_child(scene)
	await get_tree().process_frame
	next_level_position = scene.next_room_position

func update_leader_board():
	leader_board.sort_custom(func(a, b): return a.progress > b.progress)
	
	$player.ui_leaderboard = leader_board
	get_tree().create_timer(0.25).timeout.connect(update_leader_board)

func timer_timeout():
	state = 'gameplay'
	$bots.process_mode = Node.PROCESS_MODE_INHERIT
	print('start')
	$player.state = $player.states.ALIVE
