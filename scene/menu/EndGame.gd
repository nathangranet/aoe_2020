extends Control

func _ready():
	get_tree().paused = true


func _on_Button_pressed():
	get_tree().quit()
