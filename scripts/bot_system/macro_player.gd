extends Node2D

@export var rooms: Array[PackedScene]
@export var macros: Array[Resource]

func _ready() -> void:
	var next_level_position = Vector2(0, 416)
	for i in range(0, len(rooms)):
		var scene = rooms[i].instantiate()
		scene.position = next_level_position
		
		var array: Array[Resource] = [macros[i]]
		scene.get_node("checkpoint").input_chains = array
		self.add_child(scene)
		await get_tree().process_frame
		next_level_position = scene.next_room_position
