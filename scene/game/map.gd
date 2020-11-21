extends Node2D


signal new_respawn_point(point)


func _ready():
	emit_signal("new_respawn_point", $Position2D.position)


func _on_Checkpoint_checkpoint_activated(pos):
	emit_signal("new_respawn_point", pos)


func _on_Checkpoint2_checkpoint_activated(pos):
	emit_signal("new_respawn_point", pos)
