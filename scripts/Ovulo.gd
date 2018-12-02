extends Area2D


var speed = 75


func _process(delta):
	position += Vector2(-speed * delta, 0)


func _on_Ovulo_body_entered(body):
	if body.is_in_group("Player"):
		if self.call_deferred('free'):
			$CollisionShape2D.set_deferred("disabled", true)
			$CollisionShape2D.disabled = true
		$Tween.interpolate_property(self, 'modulate', 1, 0, .2, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.interpolate_property(self, 'scale', scale, Vector2(scale.x+1, scale.y+1), .2, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
		body.up()


func _on_Tween_tween_completed(object, key):
	queue_free()
