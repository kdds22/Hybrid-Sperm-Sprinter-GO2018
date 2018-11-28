extends Node2D

var pre_wall = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Walls.tscn")
var pre_coin = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Coin.tscn")
var pre_ovulo = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Ovulo.tscn")

func _ready():
	randomize()
	$Timer.start()
	$UpTimer.start()
	$Player.connect("dead", self, "game_over")


func _process(delta):
	pass


func game_over():
	get_tree().paused = true
	$Walls.hide()
	$GameOver.show()
	


func _on_Timer_timeout():
	var wall = pre_wall.instance()
	wall.position = $SpawnWalls/Position2D.position
	$Walls.add_child(wall)


func _on_UpTimer_timeout():
	var ovulo = pre_ovulo.instance()
	var pos = int(rand_range(1, 4))
	match pos:
		1:
			ovulo.position = $SpawnWalls/Position2D.position
		2:
			ovulo.position = $SpawnWalls/Position2D2.position
		3:
			ovulo.position = $SpawnWalls/Position2D3.position
		4:
			return
	$PowerUps.add_child(ovulo)
	$UpTimer.start()
