extends CharacterBody2D

@export var easyMultiplier = 5
@export var medMultiplier = 7.5
@export var hardMultiplier = 10

var speedMultiplier
var target

func _ready():
	match get_parent().difficulty:
		0:
			speedMultiplier = easyMultiplier
		1:
			speedMultiplier = medMultiplier
		2:
			speedMultiplier = hardMultiplier
	
	target = get_parent().get_node("Ball")

func _physics_process(delta):
	move_and_collide(Vector2(0, target.position.y - position.y) * speedMultiplier * delta)
