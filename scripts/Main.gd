extends Node2D

var pre_wall = preload("res://scenes/Walls.tscn")
var pre_ovulo = preload("res://scenes/Ovulo.tscn")
var main_Menu = preload("res://scenes/Menu_Main.tscn")

var ovulos
var current_ovulos = 0
var current_score
var highscore

var started = false

var flag_ovulo_lbl = false
var flag_score_lbl = false


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
	$Score_count.show()
	$Ovulo_count.show()
	get_tree().paused = false
	current_ovulos = 0


func _process(delta):
	if started:
		current_score += delta
		$Score_count/Score_count_lbl.text = str(int(current_score))


func game_over():
	started = false
	update_labels()
	get_tree().paused = true
	$Walls.hide()
	$GameOver.show()
	$PowerUps.hide()
	$Score_count.hide()
	$Ovulo_count.hide()


func ovulo_count():
	GlobalSystem.ovulos_count()
	ovulos = GlobalSystem.ovulos
	current_ovulos += 1
	$Ovulo_count/Ovulo_count_lbl.text = str(current_ovulos)
	flag_ovulo_lbl = true
	ovulo_lbl_show()


func ovulo_lbl_show():
	if flag_ovulo_lbl:
		flag_score_lbl = true
		score_count_hide()
		$Ovulo_count/Ovulo_Tween.interpolate_property($Ovulo_count, "position", Vector2(100, -20), Vector2(100, 5), .5, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Ovulo_count/Ovulo_Tween.start() 


func _on_Ovulo_Tween_tween_completed(object, key):
	if flag_ovulo_lbl:
		flag_ovulo_lbl = false
		$Ovulo_count/Ovulo_Tween.interpolate_property($Ovulo_count, "position", Vector2(100, 5), Vector2(100, -20), 2, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Ovulo_count/Ovulo_Tween.start() 


func score_count_hide():
	if flag_score_lbl:
		$Score_count/Score_Tween.interpolate_property($Score_count, "modulate", Color(1,1,1,1), Color(1,1,1,0), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Score_count/Score_Tween.start()


func _on_Score_Tween_tween_completed(object, key):
	if flag_score_lbl:
		flag_score_lbl = false
		$Score_count/Score_Tween.interpolate_property($Score_count, "modulate", Color(1,1,1,0), Color(1,1,1,1), 3, Tween.TRANS_QUAD, Tween.EASE_IN)
		$Score_count/Score_Tween.start()


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
		GlobalSystem.update_ovulos(-5)
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
			$Shop/current_ovulo_lbl.text = str(GlobalSystem.ovulos)
		2:
			$Shop/Esperm_long.hide()
			$Shop/Esperm_long_normal.show()
			$Shop/long_lbl.hide()
			$Shop/btn_BuyLong.hide()
			$Shop/ovulo_long.hide()
			$Shop/current_ovulo_lbl.text = str(GlobalSystem.ovulos)
		3:
			$Shop/Esperm_hand.hide()
			$Shop/Esperm_hand_normal.show()
			$Shop/hand_lbl.hide()
			$Shop/btn_BuyHand.hide()
			$Shop/ovulo_hand.hide()
			$Shop/current_ovulo_lbl.text = str(GlobalSystem.ovulos)
		4:
			$Shop/Esperm_cloak.hide()
			$Shop/Esperm_cloak_normal.show()
			$Shop/cloak_lbl.hide()
			$Shop/btn_BuyLong.hide()
			$Shop/ovulo_cloak.hide()
			$Shop/current_ovulo_lbl.text = str(GlobalSystem.ovulos)





