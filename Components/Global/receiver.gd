extends Resource
class_name Receiver

@export var district:District
@export var licensePlate:String = "59BG672"

func getRandomDistrict():
	var districtPath = "res://Components/Global/Districts/"
	var allDistricts = []
	
	#GET ALL DISTRICTS AVAILABLE
	for file in ResourceLoader.list_directory(districtPath):
		var isDistrict = file.contains(".tres")
		var curDistrict = load(districtPath+file) if isDistrict else null
		
		if curDistrict != null:
			allDistricts.append(curDistrict)
	
	#GET & SET RANDOM DISTRICT
	var randDistrict = randi_range(0, allDistricts.size()-1)
	district = allDistricts[randDistrict]

var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
func getLicensePlate():
	var currentLicense = ""
	
	for i in range(7):
		match i:
			_ when i <= 1:
				currentLicense += getRandomNumber()
			_ when i > 1 and i <= 3:
				currentLicense += getRandomLetter()
			_:
				currentLicense += getRandomNumber()
	
	licensePlate = currentLicense

func getRandomLetter():
	var randomLetterID = randi_range(0, alphabet.length()-1)
	
	return alphabet[randomLetterID]

func getRandomNumber():
	var randomNumber = randi_range(0, 9)
	
	return str(randomNumber)
