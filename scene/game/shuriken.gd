extends KinematicBody2D
class_name Shuriken

const SPEED = 2000

var motion = Vector2()

func _physics_process(_delta):
	motion.x = SPEED
	$Sprite.rotate(PI / 10)
	motion = move_and_slide(motion)
	var bodies = $around.get_overlapping_bodies()
	for body in bodies:
		queue_free()
