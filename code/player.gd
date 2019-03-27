extends KinematicBody2D #player

const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACCEL = 10

var vel = Vector2()
var max_speed = 300
var jump_count = 0
var jcmax = 2
var nbdjump = 5
var wjump_count = 0
var wjcmax = 2
var wnbdjump = 5

func _ready():
	pass

func _physics_process(delta):
	
	movement_loop()
	vel.y += GRAVITY * delta
	vel = move_and_slide(vel, UP)

func movement_loop():
	
	if is_on_floor() and !is_on_wall():
		jump_count = 0
		wjump_count = 0
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var dirx = int(right) - int(left)
	
	if dirx == -1 :
		vel.x = max(vel.x - ACCEL, -max_speed)
		$Sprite.flip_h = true
	elif dirx == 1 :
		vel.x = min(vel.x + ACCEL, max_speed)
		$Sprite.flip_h = false
	else:
		vel.x = lerp(vel.x, 0, 0.10)
	
	if jump == true and jump_count < jcmax:
		vel.y = -800
		jump_count += 1
		if jump_count == 2:
			nbdjump -= 1
			if nbdjump == 0:
				jcmax = 1
	elif jump == true and wjump_count < wjcmax:
		vel.y = -400
		wjump_count += 1
		if wjump_count == 5:
			wnbdjump -= 1
			if wnbdjump == 0:
				wjcmax = 1