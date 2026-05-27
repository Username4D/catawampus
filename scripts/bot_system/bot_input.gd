extends Resource

class_name BotInput

@export var input_states = {}
@export var release_events = {}
@export var press_events = {}
@export var parse_in_progress = false

func _init() -> void:
	for i in InputMap.get_actions():
		input_states[str(i)] = false
		release_events[str(i)] = false
		press_events[str(i)] = false

func press(input: String):
	input_states[input] = true
	press_events[input] = true
	await Engine.get_main_loop().physics_frame
	press_events[input] = false

func release(input: String):
	input_states[input] = false
	release_events[input] = true
	await Engine.get_main_loop().physics_frame
	release_events[input] = false

func is_action_pressed(input: String) -> bool:
	return input_states[input]

func is_action_just_pressed(input: String) -> bool:
	return press_events[input]

func is_action_just_released(input: String) -> bool:
	return release_events[input]

func parse_input_chain(input_chain: Array):
	if parse_in_progress: return
	parse_in_progress = true
	var timer = Engine.get_main_loop().create_timer(input_chain[-1].time_stamp)
	var max_time = input_chain[-1].time_stamp
	for i in input_chain:
		while not max_time - timer.time_left >= i.time_stamp:
			await Engine.get_main_loop().physics_frame
		match i.type:
			0:
				press(i.action_name)
			1:
				release(i.action_name)
	parse_in_progress = false
