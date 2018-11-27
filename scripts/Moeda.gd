extends Area2D

var speed = 75


func _process(delta):
	position += Vector2(-speed * delta, 0)


func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		$Tween.interpolate_property(self, 'modulate', 1, 0, .2, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.interpolate_property(self, 'scale', scale, Vector2(scale.x+.5, scale.y+.5), .2, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
		body.up()


func _on_Tween_tween_completed(object, key):
	queue_free()
