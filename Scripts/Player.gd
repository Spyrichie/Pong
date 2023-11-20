extends CharacterBody2D

@export var wasd = false
@export var speedMultiplier = 500.0

func _physics_process(delta):
	var inputVector = Vector2(0, 0)
	
	if wasd:
		inputVector.y = Input.get_action_raw_strength("p2_down") - Input.get_action_raw_strength("p2_up")
	else:
		inputVector.y = Input.get_action_raw_strength("p1_down") - Input.get_action_raw_strength("p1_up")
	
	move_and_collide(inputVector * speedMultiplier * delta)
