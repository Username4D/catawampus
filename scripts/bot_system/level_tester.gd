extends Node2D

const level_amount = 10

var bot_names = ["Rando1000", "Wow", "x_1999", "hunter_x", "der Bomber", "Technoblade","turkey gAmer", "espressi", "messi_10", "chungus", "67Warrrior", "urmom", "Paraguy", "Bigmac", "lost87495", "hurry cane", "can gut", "rider", "97543", "catkmnfds", "soccorgoat", "Egypt", "UNDAV", "Lost_lp09"]
@onready var leader_board = $bots.get_children()
var state = 'intro' # intro, gameplay, finished

@export var level_number = 0

func _ready() -> void:
	$bots.process_mode = Node.PROCESS_MODE_DISABLED
	$Camera.make_current()
	%timer.timer_finished.connect(timer_timeout)
	for i in $bots.get_children():
		var new_name = bot_names[randi_range(0, len(bot_names) - 1  )]
		i.name = new_name
		bot_names.erase(new_name)
	update_leader_board()
	var next_level_position: Vector2 = Vector2(0, 416)
	for i in range(0, 5):
		var scene = load("res://scenes/rooms/individual_rooms/%d.tscn" % level_number).instantiate()
		scene.position = next_level_position
		$rooms.add_child(scene)
		await get_tree().process_frame
		next_level_position = scene.next_room_position
	for i in $bots.get_children():
		i.max_x = next_level_position.x
	var scene = load("res://scenes/rooms/end_part.tscn").instantiate()
	scene.position = next_level_position
	$rooms.add_child(scene)
	await get_tree().process_frame
	next_level_position = scene.next_room_position
	
func update_leader_board():
	leader_board.sort_custom(func(a, b): return a.progress > b.progress)
	get_tree().create_timer(0.25).timeout.connect(update_leader_board)

func timer_timeout():
	state = 'gameplay'
	$bots.process_mode = Node.PROCESS_MODE_INHERIT
	print('start')
