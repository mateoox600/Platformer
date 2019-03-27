extends KinematicBody2D #player

const move_value = preload('res://data/move.gd').DATA

var vel = Vector2()
var jump_count = 0
var wjump_count = 0

func _ready():
	pass

func _physics_process(delta):
	
	movement_loop()
	vel.y += move_value[5].value * delta
	vel = move_and_slide(vel, move_value[6].value)
	print(move_value[7].value)

func movement_loop():
	
	if is_on_floor() and !is_on_wall():
		jump_count = 0
		wjump_count = 0
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var dirx = int(right) - int(left)
	
	if dirx == -1 :
		vel.x = max(vel.x - move_value[7].value, -move_value[0].value)
		$Sprite.flip_h = true
	elif dirx == 1 :
		vel.x = min(vel.x + move_value[7].value, move_value[0].value)
		$Sprite.flip_h = false
	else:
		vel.x = lerp(vel.x, 0, 0.10)
	
	if jump == true and jump_count < move_value[1].value:
		vel.y = -800
		jump_count += 1
		if jump_count == 2:
			move_value[2].value -= 1
			if move_value[2].value == 0:
				move_value[1].value = 1
	elif jump == true and wjump_count < move_value[3].value:
		vel.y = -400
		wjump_count += 1
		if wjump_count == 5:
			move_value[4].value -= 1
			if move_value[4].value == 0:
				move_value[3].value = 1