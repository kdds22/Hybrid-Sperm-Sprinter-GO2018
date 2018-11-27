extends RigidBody2D

export var speed = 140

var type = 1



func _input(event):
	if Input.is_key_pressed(KEY_SPACE) and !event.is_echo():
		swin()


func swin():
	linear_velocity = Vector2()
	apply_impulse(Vector2(), Vector2(0, -speed))
	
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
	type -= 1
	if type <= 0:
		death()

func up():
	if type >= 4:
		return
	else: 
		type += 1


func death():
	queue_free()


