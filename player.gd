extends CharacterBody2D

@export var player_id = 0
var device_id = -1
var speed = 100
var keys_held = []

func _input(event):
	if device_id != -1:
		return
	var device = -1
	if event is InputEventJoypadButton and event.pressed:
		device = event.device
	elif event is InputEventJoypadMotion and abs(event.axis_value) > 0.5:
		device = event.device
	elif event is InputEventKey and event.pressed:
		device = -2
	if device == -1:
		return
	for player in get_parent().get_children():
		if player is CharacterBody2D and player != self and player.device_id == device:
			return
	for player in get_parent().get_children():
		if player is CharacterBody2D and player.player_id < player_id and player.device_id == -1:
			return
	device_id = device

func _physics_process(delta):
	if device_id == -1:
		return
	
	var direction = Vector2.ZERO
	
	if device_id == -2:
		if Input.is_action_just_pressed("right"):
			keys_held.insert(0, "right")
		elif Input.is_action_just_pressed("left"):
			keys_held.insert(0, "left")
		elif Input.is_action_just_pressed("down"):
			keys_held.insert(0, "down")
		elif Input.is_action_just_pressed("up"):
			keys_held.insert(0, "up")
		if Input.is_action_just_released("right"):
			keys_held.erase("right")
		elif Input.is_action_just_released("left"):
			keys_held.erase("left")
		elif Input.is_action_just_released("down"):
			keys_held.erase("down")
		elif Input.is_action_just_released("up"):
			keys_held.erase("up")
		if keys_held.size() > 0:
			var key = keys_held[0]
			if key == "right":
				direction = Vector2.RIGHT
			elif key == "left":
				direction = Vector2.LEFT
			elif key == "down":
				direction = Vector2.DOWN
			elif key == "up":
				direction = Vector2.UP
	else:
		var x_axis = Input.get_joy_axis(device_id, JOY_AXIS_LEFT_X)
		var y_axis = Input.get_joy_axis(device_id, JOY_AXIS_LEFT_Y)
		if abs(x_axis) > abs(y_axis):
			if abs(x_axis) > 0.5:
				direction.x = 1 if x_axis > 0 else -1
		else:
			if abs(y_axis) > 0.5:
				direction.y = 1 if y_axis > 0 else -1
	
	velocity = direction * speed
	move_and_slide()
