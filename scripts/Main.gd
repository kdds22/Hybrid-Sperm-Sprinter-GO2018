extends Node2D

var pre_wall = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Walls.tscn")
var pre_coin = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Coin.tscn")
var pre_ovulo = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Ovulo.tscn")
var main_Menu = preload("res://Hybrid-Sperm-Sprinter-GO2018/scenes/Menu_Main.tscn")

var ovulos
var current_score
var highscore

var started = false


func update_current():
	ovulos = GlobalSystem.ovulos
	GlobalSystem.reset_current_score()
	current_score = GlobalSystem.current_score
	highscore = GlobalSystem.highscore

func _ready():
	update_current()
	update_shop()
	randomize()
	started = true
	$Timer.start()
	$UpTimer.start()
	$Player.connect("dead", self, "game_over")
	$Walls.show()
	$GameOver.hide()
	$Shop.hide()
	$PowerUps.show()
	get_tree().paused = false


func _process(delta):
	if started:
		current_score += delta


func game_over():
	started = false
	update_labels()
	get_tree().paused = true
	$Walls.hide()
	$GameOver.show()
	$PowerUps.hide()


func ovulo_count():
	GlobalSystem.ovulos_count()
	ovulos = GlobalSystem.ovulos

func update_labels():
	GlobalSystem.final_score(int(current_score))
	$GameOver/Score_lbl.text = str(int(GlobalSystem.current_score))
	$GameOver/Best_lbl.text = str(int(highscore))
	$Shop/current_ovulo_lbl.text = str(int(GlobalSystem.ovulos))


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


func _on_btn_Continue_pressed():
	get_tree().reload_current_scene()


func _on_btn_Back_pressed():
	$Shop.hide()
	$GameOver.show()


func _on_btn_Shop_pressed():
	$Shop.show()
	$GameOver.hide()


func _on_btn_BuyLong_pressed():
	if GlobalSystem.ovulos >= 5:
		GlobalSystem.change_type_player(2)
		GlobalSystem.update_ovulos(-2)
		update_shop()
		


func _on_btn_BuyHand_pressed():
	if GlobalSystem.ovulos >= 10:
		GlobalSystem.change_type_player(3)
		GlobalSystem.update_ovulos(-10)
		update_shop()


func _on_btn_BuyCloak_pressed():
	if GlobalSystem.ovulos >= 20:
		GlobalSystem.change_type_player(4)
		GlobalSystem.update_ovulos(-20)
		update_shop()

func update_shop():
	match GlobalSystem.type_player:
		1:
			$Shop/Esperm_base.show()
		2:
			$Shop/Esperm_long.hide()
			$Shop/Esperm_long_normal.show()
			$Shop/long_lbl.hide()
			$Shop/btn_BuyLong.hide()
			$Shop/ovulo_long.hide()
		3:
			$Shop/Esperm_hand.hide()
			$Shop/Esperm_hand_normal.show()
			$Shop/hand_lbl.hide()
			$Shop/btn_BuyHand.hide()
			$Shop/ovulo_hand.hide()
		4:
			$Shop/Esperm_cloak.hide()
			$Shop/Esperm_cloak_normal.show()
			$Shop/cloak_lbl.hide()
			$Shop/btn_BuyLong.hide()
			$Shop/ovulo_cloak.hide()



