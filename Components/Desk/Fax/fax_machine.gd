extends AnimatedSprite2D

@onready var paper = preload("res://Components/Desk/GrabItem/Paper/paper.tscn")
@onready var paperMarker = $Marker2D

func _ready() -> void:
	spawnPaper()

func spawnPaper() -> void:
	var paperInstance = paper.instantiate()
	get_tree().current_scene.add_child.call_deferred(paperInstance)
	paperInstance.global_position = paperMarker.global_position
	paperInstance.z_index = -1
