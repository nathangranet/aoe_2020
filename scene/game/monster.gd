extends Area2D


var player

func _on_Monster_body_entered(body):
	print ("bite")
	if body is Shuriken:
		self.queue_free()
	if body is Player:
		if body.death():
			player = body
			$AnimationPlayer.play("mega_death")


func anin_ended():
	$AnimationPlayer.play("idle")
	player.death_confirm()
