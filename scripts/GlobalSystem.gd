extends Node

var ovulos = 0
var current_score = 0
var highscore
var type_player = 1

var data = {"highscore":0, "ovulos":0, "player_type":1}

func _ready():
	highscore = 0
	load_save()

func load_save():
	var file = File.new()
	if not file.file_exists("user://save_file"):
		return
	var err = file.open("user://save_file", File.READ)
	if err == OK:
		var loading = {}
		loading = parse_json(file.get_line())
		file.close()
		highscore = loading["highscore"]
		ovulos = loading["ovulos"]
		type_player = loading["player_type"]


func save():
	data["highscore"] = highscore
	data["ovulos"] = ovulos
	data["player_type"] = type_player
	var file = File.new()
	var err = file.open("user://save_file", File.WRITE)
	if err == OK:
		file.store_string(to_json(data))
		file.close()



func ovulos_count():
	ovulos += 1

func update_ovulos(value):
	ovulos = ovulos + (value)

func reset_current_score():
	current_score = 0

func final_score(value):
	current_score = value
	update_highscore(value)

func update_highscore(value):
	if value > highscore:
		highscore = value
	save()


func change_type_player(value):
	if (value > 4) or (value < 0):
		return
	match value:
		1:
			type_player = 1
		2:
			type_player = 2
		3:
			type_player = 3
		4:
			type_player = 4
	return type_player
