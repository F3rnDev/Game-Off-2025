extends Control

@onready var mainMenuBtn = %backMainMenuConfirm
@onready var quitBtn = %quitConfirm

@onready var day: Label = $ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/TitleSection
@onready var merits: Label = $ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Merits
@onready var demerits: Label = $ArchiveOpen/Report/Margin/Content/DayInfo/Margin/Content/Demerits

@onready var goodMensage: RichTextLabel = $ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Good
@onready var badMensage: RichTextLabel = $ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Bad
@onready var neutralMensage: RichTextLabel = $ArchiveOpen/Report/Margin/Content/CitySituation/Margin/Content/Neutral

func _ready() -> void:
	mainMenuBtn.pressed.connect(backMenu)
	quitBtn.pressed.connect(quitGame)

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
