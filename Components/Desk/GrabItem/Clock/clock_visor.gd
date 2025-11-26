extends Node2D

@onready var hourLine = $HourMarker
@onready var minuteLine = $MinuteMarker

@export var hourLength = 30.0
@export var minuteLength = 26.0

func _process(_delta: float) -> void:
	calculateHourPos()
	calculateMinutePos()

func calculateHourPos():
	var angle = deg_to_rad((GameManager.hours % 12) * 30.0 + GameManager.minutes * 0.5)
	
	hourLine.rotation = angle

func calculateMinutePos():
	var angle = deg_to_rad(GameManager.minutes * 6.0)
	
	minuteLine.rotation = angle
