extends AnimatedSprite2D

@onready var paper = preload("res://Components/Desk/GrabItem/Paper/paper.tscn")
@onready var paperMarker = $Marker2D
@onready var timer = $SpawnTimer

func spawnPaper() -> void:
	var paperInstance = paper.instantiate()
	get_tree().current_scene.add_child.call_deferred(paperInstance)
	paperInstance.global_position = paperMarker.global_position
	paperInstance.z_index = -1

func setTimer():
	var time = GameManager.get_spawn_delay()
	timer.start(time)

func resetTimer():
	var time = 5.0
	if timer.time_left > time:
		timer.start(time)

func _on_spawn_timer_timeout() -> void:
	spawnPaper()
	setTimer()
