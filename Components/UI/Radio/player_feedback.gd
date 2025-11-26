extends HBoxContainer

func _ready() -> void:
	resetFeedback()

func resetFeedback():
	for points in get_children():
		var sprite:AnimatedSprite2D = points.get_child(0)
		sprite.play("default")

func setPoint(pointID:int, value:String):
	var pointToSet = get_child(pointID-1)
	var sprite:AnimatedSprite2D = pointToSet.get_child(0)
	
	sprite.play(value)
