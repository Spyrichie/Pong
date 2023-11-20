extends Node2D

@onready var onePlayerButton = $MenuButtons/OnePlayer
@onready var twoPlayerButton = $MenuButtons/TwoPlayer
@onready var soundToggle = $SoundToggle

var difficultyButtonsScene = preload("res://difficulty_buttons.tscn")

func _ready():
	onePlayerButton.connect("pressed", Callable(self, "ChooseDifficulty"))
	twoPlayerButton.connect("pressed", Callable(get_parent(), "StartTwoPlayer"))
	soundToggle.connect("toggled", Callable(get_parent(), "ToggleSound"))

func ChooseDifficulty():
	$MenuButtons.queue_free()
	var difficultyButtons = difficultyButtonsScene.instantiate()
	difficultyButtons.get_child(1).connect("pressed", Callable(self, "SetDifficultyE"))
	difficultyButtons.get_child(2).connect("pressed", Callable(self, "SetDifficultyM"))
	difficultyButtons.get_child(3).connect("pressed", Callable(self, "SetDifficultyH"))
	add_child(difficultyButtons)

func SetDifficultyE():
	get_parent().StartSinglePlayer(0)

func SetDifficultyM():
	get_parent().StartSinglePlayer(1)

func SetDifficultyH():
	get_parent().StartSinglePlayer(2)
