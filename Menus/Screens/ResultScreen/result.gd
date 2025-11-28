extends Control

@onready var mainMenuBtn = %backMainMenuConfirm
@onready var quitBtn = %quitConfirm

@onready var day: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/TitleSection
@onready var merits: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Merits
@onready var demerits: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Demerits

@onready var goodMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Good
@onready var badMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Bad
@onready var neutralMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Neutral

func _ready() -> void:
	mainMenuBtn.pressed.connect(backMenu)
	quitBtn.pressed.connect(quitGame)
	
	setUI()

func setUI():
	day.text = "DAY " + str(GameManager.day)
	merits.text = "Quantity of merits: " + str(GameManager.dayMerits)
	demerits.text = "Quantity of demerits: " + str(GameManager.totalPoints - GameManager.dayMerits)
	
	setCityStatus()

func setCityStatus():
	goodMensage.visible = false
	badMensage.visible = false
	neutralMensage.visible = false
	
	var totalMerits = GameManager.dayMerits
	var totalDemerits = (GameManager.totalPoints - GameManager.dayMerits)
	
	if totalMerits > totalDemerits:
		goodMensage.visible = true
	elif totalMerits == totalDemerits:
		neutralMensage.visible = true
	else:
		badMensage.visible = true

func backMenu():
	#get_tree().change_scene_to_file("res://Screens/MenuScreen/menu_screen.tscn")
	print("Mudar cena para menu principal - Script de result")
	
func quitGame():
	get_tree().quit()

	#== Buttons ==#
func btnPress() -> void:
	Audio.playUIAccept()

func denyBtnPressed() -> void:
	Audio.playUICancel()
