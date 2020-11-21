extends KinematicBody2D
class_name Player


signal player_die()


export(int) var SPEED = 1000
export(int) var JUMP_HEIGHT = 1100
export(int) var GRAVITY = 38
export(bool) var CAN_MOVE = true
export(float) var SLIDE_DURATION = 1
export(float) var HIDE_DURATION = 1
export(float) var STEALTH_COOLDOWN = 1

var vel = Vector2.ZERO
var slide_timer = Timer.new()
var stealth_timer = Timer.new()
var cooldown_timer = Timer.new()
var stealth = false
var stealth_block = false

func _ready():
	slide_timer.connect("timeout", self, "_on_slide_timer_timeout")
	slide_timer.one_shot = true
	self.add_child(slide_timer)
	stealth_timer.connect("timeout", self, "_on_stealth_timer_timeout")
	stealth_timer.one_shot = true
	self.add_child(stealth_timer)
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	cooldown_timer.one_shot = true
	self.add_child(cooldown_timer)


func _physics_process(delta):
	if CAN_MOVE:
		update_velocity()
		vel = move_and_slide(vel, Vector2.UP)
		if Input.is_action_just_pressed("movement_slide"):
			slide()
		if Input.is_action_just_pressed("movement_stealth") and !stealth_block:
			stealth()


func update_velocity():
	vel.x = SPEED
	if Input.is_action_pressed("movement_jump") and is_on_floor():
		vel.y -= JUMP_HEIGHT
	if is_on_wall():
		emit_signal("player_die")
	vel.y += GRAVITY 


func death() -> bool:
	if stealth:
		return false
	CAN_MOVE = false
	slide_timer.stop()
	stealth_timer.stop()
	cooldown_timer.stop()
	stealth = false
	stealth_block = false
	$AnimationPlayer.stop()
	return true


func death_confirm():
	CAN_MOVE = true
	emit_signal("player_die")
	$AnimationPlayer.play("runing")


func stealth():
	stealth = true
	$Node2D.modulate = Color(1, 1, 1, 0.5)
	stealth_timer.start(HIDE_DURATION)
	stealth_block = true


func slide():
	$WalkCollisionShape2D.disabled = true
	$SlideCollisionShape2D2.disabled = false
	$AnimationPlayer.play("slide")
	slide_timer.start(SLIDE_DURATION)


func _on_slide_timer_timeout():
	$AnimationPlayer.play("runing")
	$WalkCollisionShape2D.disabled = false
	$SlideCollisionShape2D2.disabled = true


func _on_stealth_timer_timeout():
	stealth = false
	$Node2D.modulate = Color(1, 1, 1, 1)
	cooldown_timer.start(STEALTH_COOLDOWN)


func _on_cooldown_timer_timeout():
	stealth_block = false
