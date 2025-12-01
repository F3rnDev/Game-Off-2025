extends Control

var weekStatus:GameManager.CityStatus = GameManager.CityStatus.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.playMusic() # Replace with function body.
	
	setStatus()
	updateUI()

func updateUI():
	for status in $CityStatus.get_children():
		status.visible = false
	
	match weekStatus:
		GameManager.CityStatus.NORMAL:
			$TextureRect/Label.text = "GOOD JOB!"
			$CityStatus/Normal.visible = true
		GameManager.CityStatus.GOOD:
			$TextureRect/Label.text = "PROMOTION!"
			$CityStatus/Good.visible = true
		GameManager.CityStatus.BAD:
			$TextureRect/Label.text = "YOU'RE FIRED!"
			$CityStatus/Bad.visible = true

func setStatus():
	var statusDict = {}
	
	var normalAmnt = GameManager.curCityStatus.count(GameManager.CityStatus.NORMAL)
	var goodAmnt = GameManager.curCityStatus.count(GameManager.CityStatus.GOOD)
	var badAmnt = GameManager.curCityStatus.count(GameManager.CityStatus.BAD)
	
	statusDict[GameManager.CityStatus.NORMAL] = normalAmnt
	statusDict[GameManager.CityStatus.GOOD] = goodAmnt
	statusDict[GameManager.CityStatus.BAD] = badAmnt
	
	var max_count = max(normalAmnt, goodAmnt, badAmnt)
	var winners = []

	for status in statusDict.keys():
		if statusDict[status] == max_count:
			winners.append(status)

	#ONE WINNER
	if winners.size() == 1:
		weekStatus = winners[0]
		return

	# GOOD and BAD tie
	if GameManager.CityStatus.GOOD in winners and GameManager.CityStatus.BAD in winners:
		weekStatus = GameManager.CityStatus.NORMAL
		return

	# GOOD and NORMAL tie
	if GameManager.CityStatus.GOOD in winners and GameManager.CityStatus.NORMAL in winners:
		weekStatus = GameManager.CityStatus.GOOD
		return

	# BAD and NORMAL tie
	if GameManager.CityStatus.BAD in winners and GameManager.CityStatus.NORMAL in winners:
		weekStatus = GameManager.CityStatus.BAD
		return

func _on_button_button_down() -> void:
	Audio.playUIAccept()
	GameManager.resetData()
	Transition.transitionToScene("res://Menus/Screens/MenuScreen/menu_screen.tscn", "result")
