extends ColorRect
@onready var plateLabel:Label = $Label

func _ready() -> void:
	$AnimationPlayer.play("Appear")

func setPlate(plate:String):
	plateLabel.text = plate
