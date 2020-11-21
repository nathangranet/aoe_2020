extends Area2D

signal game_ended()

func _on_EndDetector_body_entered(body):
	if body is Player:
		emit_signal("game_ended")
