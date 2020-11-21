extends Area2D


var player

func _on_Monster_body_entered(body):
	if body is Player:
		if body.death():
			player = body
			$AnimationPlayer.play("mega_death")


func anin_ended():
	$AnimationPlayer.play("idle")
	player.death_confirm()
