extends Area2D


signal checkpoint_activated(pos)


func _on_Checkpoint_body_entered(body):
	if body is Player:
		$Particles2D.emitting = true
		emit_signal("checkpoint_activated", self.global_position - Vector2(0, 135))
