extends Sprite2D

@onready var grab = $GrabbableItem
@onready var parent:Item = get_parent().get_parent()
@onready var paperReceiver = preload("res://Components/Desk/GrabItem/Paper/paperReceiver.tscn")
@onready var receiverContainer = $Texts/VBox
@onready var animation = $AnimationPlayer

@export var unzoomScale = Vector2(4.0, 4.0)
@export var zoomScale = Vector2(8.0, 8.0)

@export var receivers:Array[Receiver]

var inReader = false
var readerObj = null

var insideReader = false
var messageSent = false

func _ready() -> void:
	generatePaper(3)#Change to global amnt

func generatePaper(receiverAmount):
	for receiverID in range(receiverAmount):
		var recvr:Receiver = Receiver.new()
		recvr.getRandomDistrict()
		recvr.getLicensePlate()
		
		receivers.append(recvr)
	
	updatePaperUI()
	animation.play("paper up")

func updatePaperUI():
	for recvr in receivers:
		var recvrInstance = paperReceiver.instantiate()
		receiverContainer.add_child(recvrInstance)
		
		recvrInstance.updatePlate(recvr.licensePlate)
		recvrInstance.updateDistrict(recvr.district.image)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if animation.is_playing() or insideReader:
		grab.disabled = true
	else:
		grab.disabled = false
	
	if grab.drag and !parent.onDesk and !inReader:
		get_parent().scale = zoomScale
	else:
		get_parent().scale = unzoomScale
	
	if !grab.drag and inReader and !messageSent:
		dropPaperInReader()

func dropPaperInReader():
	if !insideReader:
		parent.stop = true
		readerObj.setItem(false)
		parent.global_position = readerObj.getPaperInPos()
		animation.play("paper reader down")
		
		insideReader = true
	
	if insideReader and !animation.is_playing():
		readerObj.getInfo(receivers)
		messageSent = true

func _on_reader_identify_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reader"):
		inReader = true
		readerObj = area.get_parent()
		readerObj.setItem(true)

func _on_reader_identify_area_exited(area: Area2D) -> void:
	if area.is_in_group("Reader"):
		inReader = false
		readerObj.setItem(false)
		readerObj = null
