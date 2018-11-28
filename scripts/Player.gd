extends RigidBody2D

export var speed = 140

var type = 1
var flag_tween = false

signal dead



func _input(event):
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(BUTTON_LEFT) and !event.is_echo():
		swin()
#	if Input.is_key_pressed(KEY_H) and !event.is_echo(): #for testing hit
#		hit()


func swin():
	linear_velocity = Vector2()
	apply_impulse(Vector2(), Vector2(0, -speed))
	choose_state()


func choose_state():
	match type:
		1:
			$AnimationPlayer.play("base_idle")
			Engine.time_scale = 1
		2:
			$AnimationPlayer.play("long_idle")
			Engine.time_scale = 1
		3:
			$AnimationPlayer.play("hand_idle")
			Engine.time_scale = 1
		4:
			$AnimationPlayer.play("hero_idle")
			Engine.time_scale = 1.2

func hit():
	type -= 1
	choose_state()
	if type <= 0:
		death()
	if !flag_tween:
		flag_tween = true
		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 1, 1, 1), Color(1, 0, 0, 1), .2, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		$Tween.start()
	

func _on_Tween_tween_completed(object, key):
	if flag_tween:
		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 0, 0, 1), Color(1, 1, 1, 1), .2, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()
		flag_tween = false


func up():
	if type >= 4:
		return
	else: 
		type += 1
		choose_state()
	if !flag_tween:
		flag_tween = true
		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 1, 1, 1), Color(0, 0, 1, 1), .2, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		$Tween.start()


func death():
	emit_signal("dead")
	queue_free()

