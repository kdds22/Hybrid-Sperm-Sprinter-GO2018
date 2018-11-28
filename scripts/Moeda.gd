extends Area2D

var speed = 75


func _process(delta):
	position += Vector2(-speed * delta, 0)


func _on_Coin_body_entered(body):
	pass


func _on_Tween_tween_completed(object, key):
	queue_free()
