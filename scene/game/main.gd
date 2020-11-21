extends Node2D


onready var respawn_point = $map/Position2D.global_position


func _ready():
	$map.connect("new_respawn_point", self, "_on_respawn_point_change")


func _on_respawn_point_change(point):
	respawn_point = point


func _on_bonom_player_die():
	$bonom.global_position = respawn_point


func _on_EndDetector_game_ended():
	var tmp = load("res://scene/menu/EndGame.tscn")
	var inst = tmp.instance()
	
	inst.rect_position = $bonom/Camera2D.global_position
	self.add_child(inst)
