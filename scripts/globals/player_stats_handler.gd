extends Node

var player_skin = 0
var player_trophies = 247
var music_volume = 7
var sfx_volume = 7

func save():
	var content = {"player_skin": player_skin, "player_trophies": player_trophies, "music_volume": music_volume, "sfx_volume": sfx_volume}
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_var(content)

func _load():
	var file = FileAccess.open("user://save.dat", FileAccess.READ)
	if file:
		var content = file.get_var()
		player_skin = content["player_skin"]
		player_trophies = content["player_trophies"]
		music_volume = content["music_volume"]
		sfx_volume = content["sfx_volume"]

func _ready() -> void:
	_load()
