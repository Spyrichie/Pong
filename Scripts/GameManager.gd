extends Node2D


@onready var p1Goal = $P1Goal
@onready var p2Goal = $P2Goal
@onready var P1Scoreboard = $P1Score
@onready var P2Scoreboard = $P2Score
@onready var ball = $Ball

var p1WinUIPos = Vector2(448, 256)
var p2WinUIPos = Vector2(192, 256)

var winMenuScene = preload("res://win_menu.tscn")
var ballStartPos = Vector2(320, 248)
var serveDir = -1
var p1Score = 0
var p2Score = 0
var allowSound = false

var difficulty
var winMenu

func _ready():
	p1Goal.connect("scored", Callable(self, "P2Scored"))
	p2Goal.connect("scored", Callable(self, "P1Scored"))
	P1Scoreboard.text = "0"
	P2Scoreboard.text = "0"
	ball.playSound = allowSound

func P1Scored():
	p1Score += 1
	P1Scoreboard.text = str(p1Score)
	ServeBall()

func P2Scored():
	p2Score += 1
	P2Scoreboard.text = str(p2Score)
	ServeBall()

func ServeBall():
	if !CheckScore():
		return
	
	var yDir = randf_range(-1, 1)
	
	while yDir < 0.3 && yDir > -0.3:
		yDir = randf_range(-1, 1)
	
	ball.position = ballStartPos
	ball.v = Vector2(serveDir, yDir)
	serveDir *= -1

func CheckScore():
	if p1Score == 10:
		winMenu = winMenuScene.instantiate()
		winMenu.get_node("Restart").connect("pressed", Callable(get_parent(), "Reset"))
		winMenu.get_node("MainMenu").connect("pressed", Callable(get_parent(), "StartMainMenu"))
		winMenu.position = p1WinUIPos
		add_child(winMenu)
		return false
	elif p2Score == 10:
		winMenu = winMenuScene.instantiate()
		winMenu.get_node("Restart").connect("pressed", Callable(get_parent(), "Reset"))
		winMenu.get_node("MainMenu").connect("pressed", Callable(get_parent(), "StartMainMenu"))
		winMenu.position = p2WinUIPos
		add_child(winMenu)
		return false
	else:
		return true

