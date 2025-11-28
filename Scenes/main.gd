extends Node2D

@onready var dayTimer:Timer = $DayTimer
@export var dayTime = 7.0 #7 minutes

@onready var radioUI:RadioUI = $CanvasLayer/RadioUI

var totalSeconds = 0.0

var dayStarted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FaxMachine.spawnPaper()
	
	totalSeconds = dayTime*60.0
	dayTimer.wait_time = totalSeconds
	GameManager.setDayStatus(GameManager.DayStatus.STOPPED)
	GameManager.resetDayMerits()

func _process(_delta: float) -> void:
	if GameManager.curDayStatus == GameManager.DayStatus.STOPPED:
		return
	
	if dayTimer.is_stopped() and !dayStarted:
		dayStarted = true
		dayTimer.start()
		$FaxMachine.setTimer()
	
	if GameManager.curDayStatus == GameManager.DayStatus.RUNNING:
		var elapsed = totalSeconds - dayTimer.time_left
		GameManager.setTime(elapsed, totalSeconds)

func showRadio():
	if !radioUI.appeared:
		radioUI.showUI()
	else:
		radioUI.hideUI()

func getRadioUI():
	return radioUI

func _on_day_timer_timeout() -> void:
	GameManager.setDayStatus(GameManager.DayStatus.OVER)
	
	#get_tree().change_scene_to_file("res://Menus/Screens/ResultScreen/result_screen.tscn")
	Transition.transitionToScene("res://Menus/Screens/ResultScreen/result_screen.tscn", "result")
