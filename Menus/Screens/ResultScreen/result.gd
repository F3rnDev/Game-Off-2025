extends Control

@onready var mainMenuBtn = %backMainMenuConfirm
@onready var quitBtn = %quitConfirm

@onready var day: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/TitleSection
@onready var merits: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Merits
@onready var demerits: Label = $Control/ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Demerits

@onready var goodMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Good
@onready var badMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Bad
@onready var neutralMensage: RichTextLabel = $Control/ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Neutral

var curDay = 1

func _ready() -> void:
	Audio.playMusic()
	mainMenuBtn.pressed.connect(backMenu)
	quitBtn.pressed.connect(quitGame)
	
	setUI()
	
	
	curDay = GameManager.day
	if GameManager.day < 5:
		GameManager.day += 1

func setUI():
	day.text = "DAY " + str(GameManager.day)
	merits.text = "Quantity of merits: " + str(GameManager.dayMerits)
	demerits.text = "Quantity of demerits: " + str(GameManager.totalPoints - GameManager.dayMerits)
	
	setCityStatus()
	
	#CheckWeb
	if OS.has_feature("web"):
		$Control/Buttons/Quit.visible = false

func setCityStatus():
	goodMensage.visible = false
	badMensage.visible = false
	neutralMensage.visible = false
	
	var totalMerits = GameManager.dayMerits
	var totalDemerits = (GameManager.totalPoints - GameManager.dayMerits)
	
	if totalMerits > totalDemerits:
		goodMensage.visible = true
		GameManager.curCityStatus.append(GameManager.CityStatus.GOOD)
	elif totalMerits == totalDemerits:
		neutralMensage.visible = true
		GameManager.curCityStatus.append(GameManager.CityStatus.NORMAL)
	else:
		badMensage.visible = true
		GameManager.curCityStatus.append(GameManager.CityStatus.BAD)

func backMenu():
	Transition.transitionToScene("res://Menus/Screens/MenuScreen/menu_screen.tscn", "result")
	
func quitGame():
	get_tree().quit()

	#== Buttons ==#
func btnPress() -> void:
	Audio.playUIAccept()

func _on_continue_button_down() -> void:
	if curDay < 5:
		Audio.stopMusic()
		Transition.transitionToScene("res://Scenes/main.tscn", "circleToDay")
	else:
		Transition.transitionToScene("res://Menus/Screens/EndScreen/endScreen.tscn", "result")
