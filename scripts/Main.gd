extends Node2D

var pre_wall = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Walls.tscn")
var pre_coin = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Coin.tscn")


func _ready():
	randomize()
	$Timer.start()
	$UpTimer.start()


func _on_Timer_timeout():
	var wall = pre_wall.instance()
	wall.position = $SpawnWalls/Position2D.position
	add_child(wall)


func _on_UpTimer_timeout():
	var coin = pre_coin.instance()
	coin.position = $SpawnWalls/Position2D.position
	add_child(coin)
	$UpTimer.start()
