extends Node2D

onready var main = load("res://scenes/Main.tscn")

func _ready():
	$Tween.interpolate_property($Sperm, "position", Vector2(-25, 166), Vector2(74, 84), 1.8, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.interpolate_property($figurantes_1, "position", Vector2(-100, 82), Vector2(0, 0), 2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.interpolate_property($figurantes_2, "position", Vector2(-100, 82), Vector2(0, 0), 2.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.interpolate_property($Logo, "position", Vector2(-95, 30), Vector2(100, 30), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Ovulo, "position", Vector2(300, -28), Vector2(229, 29), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Start_btn, "rect_position", Vector2(270, 80), Vector2(147, 80), 2.8, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.interpolate_property($Exit_btn, "rect_position", Vector2(270, 110), Vector2(147, 110), 2.9, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()


func _on_Start_btn_pressed():
	get_tree().change_scene_to(main)


func _on_Exit_btn_pressed():
	get_tree().quit()
