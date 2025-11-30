extends Sprite2D

@onready var grab = $GrabbableItem
@onready var parent:Item = get_parent().get_parent()
@onready var paperReceiver = preload("res://Components/Desk/GrabItem/Paper/paperReceiver.tscn")
@onready var receiverContainer = $Texts/VBox
@onready var animation = $AnimationPlayer
@onready var checkMark = $Sprite2D

@export var unzoomScale = Vector2(4.0, 4.0)
@export var zoomScale = Vector2(8.0, 8.0)

@export var receivers:Array[Receiver]

var inReader = false
var readerObj = null

var insideReader = false
var messageSent = false

var inFolder = false

var playedSoundSfx = false

func _ready() -> void:
	generatePaper(GameManager.get_required_points())#Change to global amnt
	checkMark.visible = false

func generatePaper(receiverAmount):
	GameManager.totalPoints += receiverAmount
	
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
	
	if grab.drag and !parent.onDesk and !inReader and !messageSent:
		get_parent().scale = zoomScale
		
		if !playedSoundSfx:
			Audio.playUIAccept(-10.0)
			playedSoundSfx = true
	else:
		get_parent().scale = unzoomScale
	
	if !grab.drag and inReader and !messageSent:
		dropPaperInReader()
	elif !grab.drag and inFolder and messageSent:
		Audio.playUIAccept(-10.0)
		parent.queue_free()
	
	if grab.drag and GameManager.curDayStatus == GameManager.DayStatus.STOPPED:
		GameManager.setDayStatus(GameManager.DayStatus.RUNNING)
	
	#RESET SOUNDSFX
	if !grab.drag:
		playedSoundSfx = false
	
func dropPaperInReader():
	if !insideReader and !readerObj.hasPaper:
		parent.stop = true
		readerObj.setItem(false)
		readerObj.setReaderStatus(true)
		parent.global_position = readerObj.getPaperInPos()
		animation.play("paper reader down")
		readerObj.setCurPaper(self)
		
		insideReader = true
	
	if insideReader and !animation.is_playing():
		readerObj.getInfo(receivers)
		messageSent = true

func removeFromReader(readerPos):
	parent.global_position = readerPos
	animation.play("paper reader up")
	checkMark.visible = true
	
	insideReader = false

func setPaperAudioPitch(pitch = -1):
	if pitch == -1:
		pitch = randf_range(0.5, 1.0)
	
	print(pitch)
	$AnimationPlayer/FaxOut.pitch_scale = pitch

func _on_reader_identify_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reader") and !messageSent:
		inReader = true
		readerObj = area.get_parent()
		
		if !readerObj.hasPaper:
			readerObj.setItem(true)

func _on_reader_identify_area_exited(area: Area2D) -> void:
	if area.is_in_group("Reader") and !messageSent:
		inReader = false
		if !readerObj.hasPaper:
			readerObj.setItem(false)
		
		readerObj = null


func _on_folder_identify_area_entered(area: Area2D) -> void:
	if area.is_in_group("Folder")  and messageSent and grab.drag:
		area.get_parent().setItem(true)
		inFolder = true

func _on_folder_identify_area_exited(area: Area2D) -> void:
	if area.is_in_group("Folder") and messageSent and grab.drag:
		area.get_parent().setItem(false)
		inFolder = false
