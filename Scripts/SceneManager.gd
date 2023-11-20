extends Node2D

var startMenuScene = preload("res://start_menu.tscn")
var singlePlayerGameScene = preload("res://onePlayer.tscn")
var twoPlayerGameScene = preload("res://twoPlayer.tscn")

var startMenu
var currentGame
var difficulty

var mode = 0
var allowSound = false

func _ready():
	startMenu = startMenuScene.instantiate()
	add_child(startMenu)

func _input(_event):
	if Input.is_action_pressed("reset"):
		Reset()
	if Input.is_key_pressed(KEY_ESCAPE):
		mode = 0
		ToggleSound(false)
		if is_instance_valid(currentGame):
			currentGame.queue_free()
		startMenu = startMenuScene.instantiate()
		add_child(startMenu)

func StartSinglePlayer(dif):
	mode = 1
	
	if is_instance_valid(startMenu):
		startMenu.queue_free()
	
	currentGame = singlePlayerGameScene.instantiate()
	currentGame.difficulty = dif
	difficulty = dif
	currentGame.allowSound = allowSound
	add_child(currentGame)

func StartTwoPlayer():
	mode = 2
	
	if is_instance_valid(startMenu):
		startMenu.queue_free()
	
	currentGame = twoPlayerGameScene.instantiate()
	currentGame.allowSound = allowSound
	add_child(currentGame)

func StartMainMenu():
	mode = 0
	ToggleSound(false)
	if is_instance_valid(currentGame):
		currentGame.queue_free()
	
	startMenu = startMenuScene.instantiate()
	add_child(startMenu)

func Reset():
	match mode:
		0:
			pass
		1:
			currentGame.queue_free()
			await get_tree().create_timer(0.01).timeout
			StartSinglePlayer(difficulty)
		2:
			currentGame.queue_free()
			await get_tree().create_timer(0.01).timeout
			StartTwoPlayer()

func ToggleSound(soundAllowed: bool):
	allowSound = soundAllowed
