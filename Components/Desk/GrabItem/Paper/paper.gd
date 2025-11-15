extends Sprite2D

@onready var grab = $GrabbableItem
@onready var parent:Item = get_parent()
@onready var paperReceiver = preload("res://Components/Desk/GrabItem/Paper/paperReceiver.tscn")
@onready var receiverContainer = $Texts/VBox
@onready var animation = $AnimationPlayer

@export var unzoomScale = Vector2(4.0, 4.0)
@export var zoomScale = Vector2(8.0, 8.0)

@export var receivers:Array[Receiver]

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
	if animation.is_playing():
		grab.disabled = true
	else:
		grab.disabled = false
	
	if grab.drag and !parent.onDesk:
		scale = zoomScale
	else:
		scale = unzoomScale
