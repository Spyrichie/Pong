extends CharacterBody2D

@export var speedMultiplier = 250.0
@export var v = Vector2(0.75, 0.75)
@export var soundFile = preload("res://hit.mp3")

var audioStream
var playSound

func _ready():
	audioStream = AudioStreamPlayer.new()
	audioStream.stream = soundFile
	add_child(audioStream)

func _input(_event):
	if Input.is_key_pressed(KEY_F):
		speedMultiplier = 1000.0

func _physics_process(delta):
	var collisionInfo = move_and_collide(v * speedMultiplier * delta)
	if collisionInfo:
		if playSound:
			audioStream.play()
		v = v.bounce(collisionInfo.get_normal())
		if v * 1.05 < Vector2(2.5, 2.5) && v * 1.05 > Vector2(-2.5, -2.5):
			v *= 1.05
