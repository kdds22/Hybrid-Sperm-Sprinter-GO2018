extends Node

var ovulos = 0
var current_score = 0
var highscore
var type_player = 1


func _ready():
	highscore = 0


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
