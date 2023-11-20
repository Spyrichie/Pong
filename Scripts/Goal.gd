extends Area2D

signal scored

func _ready():
	connect("body_entered", Callable(self, "BodyEntered"))
	collision_layer = 0
	collision_mask = 1

func BodyEntered(_area):
	emit_signal("scored")
