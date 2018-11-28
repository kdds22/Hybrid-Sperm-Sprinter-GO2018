extends Area2D

export var speed = 100
var ocilation = 20

var flag = true



func _ready():
	randomize()
	$Timer.start()


func _process(delta):
	if flag:
		position += Vector2(-speed * delta, ocilation * delta)
	else: 
		position += Vector2(-speed * delta, -ocilation * delta)
		
	if position.x <= -50:
		queue_free()


func _on_Timer_timeout():
	$Timer.wait_time = rand_range(.2,2.5)
	$Timer.start()
	flag = !flag

func _on_Walls_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("hit")
		body.hit()



