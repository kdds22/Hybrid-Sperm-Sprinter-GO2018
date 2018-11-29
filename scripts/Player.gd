extends RigidBody2D

export var speed = 140

var type = 1
var flag_tween = false

signal dead


func _ready():
	choose_state()


func _input(event):
	if Input.is_key_pressed(KEY_SPACE) and !event.is_echo():
		swin()

func swin():
	linear_velocity = Vector2()
	apply_impulse(Vector2(), Vector2(0, -speed))
	_type()



func choose_state():
	type = GlobalSystem.type_player
	_type()

func _type():
	match type:
		1:
			$AnimationPlayer.play("base_idle")
		2:
			$AnimationPlayer.play("long_idle")
		3:
			$AnimationPlayer.play("hand_idle")
		4:
			$AnimationPlayer.play("hero_idle")

func hit():
	if !flag_tween:
		flag_tween = true
		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 1, 1, 1), Color(1, 0, 0, 1), .2, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		$Tween.start()

	death()
	

func _on_Tween_tween_completed(object, key):
	if flag_tween:
		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 0, 0, 1), Color(1, 1, 1, 1), .2, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()
		flag_tween = false


func up():
	get_parent().ovulo_count()
	pass
#	if type >= 4:
#		return
#	else: 
#		type += 1
#		choose_state()
#	if !flag_tween:
#		flag_tween = true
#		$Tween.interpolate_property($Sprite, 'modulate', Color(1, 1, 1, 1), Color(0, 0, 1, 1), .2, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
#		$Tween.start()


func death():
	emit_signal("dead")
	queue_free()

