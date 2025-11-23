extends Node2D

@onready var dayTimer = $DayTimer
@export var dayTime = 7.0 #7 minutes

@onready var radioUI:RadioUI = $CanvasLayer/RadioUI

var totalSeconds = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	totalSeconds = dayTime*60.0
	dayTimer.wait_time = totalSeconds
	dayTimer.start()

func _process(_delta: float) -> void:
	var elapsed = totalSeconds - dayTimer.time_left
	GameManager.setTime(elapsed, totalSeconds)

func showRadio():
	if !radioUI.appeared:
		radioUI.showUI()
	else:
		radioUI.hideUI()

func getRadioUI():
	return radioUI
