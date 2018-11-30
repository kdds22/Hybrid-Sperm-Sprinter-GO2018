extends Node2D

onready var main = load("res://scenes/Menu_Main.tscn")


func _on_Timer_timeout():
	get_tree().change_scene_to(main)
