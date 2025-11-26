extends Panel

class_name RadioUI

@export var radioStation:Node2D

@onready var receiverPoint = preload("res://Components/Desk/Radio/receiverPoint.tscn")
@onready var control = $TextureRect/SubViewportContainer/SubViewport/Polygraph/PointAdd
@onready var visorViewport = $TextureRect/SubViewportContainer/SubViewport
@onready var anim = $AnimationPlayer

@onready var feedback = $TextureRect/PlayerFeedback
@onready var districtSlider = $TextureRect/SubViewportContainer/SubViewport/DistrictSlider
@onready var knob = $TextureRect/Knob

var min_dist = 50.0
var max_points = 5

var appeared = false

var activeRecvrs:Array[Receiver] = []

var pointAmount = 0
var pointsSent = 0

func getViewport():
	return visorViewport

func showUI():
	appeared = true
	anim.play("Appear")

func hideUI():
	appeared = false
	anim.play("Disappear")

func updateRadio(curRecvr:Array[Receiver]):
	activeRecvrs = curRecvr
	pointAmount = curRecvr.size()
	feedback.resetFeedback()
	
	var addedPoints = 0
	
	for recvr in curRecvr:
		addRadioPoint(recvr)
		addedPoints += 1
	
	for id in range(max_points-addedPoints):
		var recvr = Receiver.new()
		recvr.getRandomDistrict()
		recvr.getLicensePlate()
		addRadioPoint(recvr)

func addRadioPoint(recvr):
	var pointInstance:TextureRect = receiverPoint.instantiate()
	
	#SetPos
	var pointSize = Vector2(pointInstance.size.x * pointInstance.scale.x, pointInstance.size.y * pointInstance.scale.y)
	var yPos = randf_range(0.0, control.size.y - pointSize.y)
	var xPos = 0.0
	
	var tries = 0
	var fallback = 30
	
	while true:
		xPos = randf_range(0.0, control.size.x - pointSize.x)
		
		if _is_x_valid(xPos):
			break
		
		tries+=1
		if tries >= fallback:
			print("Aviso: posição X ideal não encontrada, adicionando mesmo assim.")
			break
	
	pointInstance.position = Vector2(xPos, yPos)
	pointInstance.setReceiver(recvr)
	
	control.add_child(pointInstance)

func _is_x_valid(xPos: float) -> bool:
	for child in control.get_children():
		if child is TextureRect:
			var existing_left = child.position.x
			var existing_right = child.position.x + child.size.x * child.scale.x
			
			# Verifica distância mínima APENAS NO EIXO X
			if abs(xPos - existing_left) < min_dist or abs(xPos - existing_right) < min_dist:
				return false
			
	return true


func _on_send_button_down() -> void:
	await get_tree().process_frame
	if districtSlider.selectedPoint.size() <= 0:
		return
	
	pointsSent += 1
	
	var curRecvr = activeRecvrs.find(districtSlider.selectedPoint[0].receiver)
	
	if curRecvr == -1 or !knob.is_in_target():
		wrongSignal()
	else:
		rightSignal()
	
	#Remove receiver (object and info)
	var object = districtSlider.selectedPoint[0]
	object.killReceiver()
	
	if curRecvr != -1:
		activeRecvrs.remove_at(curRecvr)
	
	#Compare
	if pointsSent == pointAmount:
		allSignalsSent()

func allSignalsSent():
	for child in control.get_children():
		child.killReceiver()
	
	radioStation.removePaper()

func wrongSignal():
	GameManager.dayDemerits += 1
	feedback.setPoint(pointsSent, "no")

func rightSignal():
	GameManager.dayMerits += 1
	feedback.setPoint(pointsSent, "yes")
