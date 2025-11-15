extends HBoxContainer

@onready var plate = $Label
@onready var district = $TextureRect

func updatePlate(text):
	plate.text = text

func updateDistrict(districtImage):
	district.texture = districtImage
