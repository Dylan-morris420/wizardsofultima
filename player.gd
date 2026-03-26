extends CharacterBody2D

const SPEED = 100

var dir = Vector2.ZERO

func _physics_process(delta):
	# Only update direction if we're not already moving
	if dir == Vector2.ZERO:
		if Input.is_action_pressed("right"):
			dir = Vector2(1, 0)
		elif Input.is_action_pressed("left"):
			dir = Vector2(-1, 0)
		elif Input.is_action_pressed("down"):
			dir = Vector2(0, 1)
		elif Input.is_action_pressed("up"):
			dir = Vector2(0, -1)

	# Stop moving if the current key is released
	if dir == Vector2(1, 0) and not Input.is_action_pressed("right"):
		dir = Vector2.ZERO
	elif dir == Vector2(-1, 0) and not Input.is_action_pressed("left"):
		dir = Vector2.ZERO
	elif dir == Vector2(0, 1) and not Input.is_action_pressed("down"):
		dir = Vector2.ZERO
	elif dir == Vector2(0, -1) and not Input.is_action_pressed("up"):
		dir = Vector2.ZERO

	velocity = dir * SPEED
	move_and_slide()
