extends AnimatedSprite2D

@onready var paper = preload("res://Components/Desk/GrabItem/Paper/paper.tscn")
@onready var paperMarker = $Marker2D
@onready var timer = $SpawnTimer

var paperAmount = 0

func spawnPaper() -> void:
	var paperInstance:Item = paper.instantiate()
	get_tree().current_scene.add_child.call_deferred(paperInstance)
	paperInstance.global_position = paperMarker.global_position
	paperInstance.z_index = -1
	
	paperAmount += 1

func setTimer():
	var time = GameManager.get_spawn_delay()
	timer.start(time)

func resetTimer():
	paperAmount -= 1
	
	if paperAmount > 0:
		return
	
	var time = 5.0
	if timer.time_left > time:
		timer.start(time)

func _on_spawn_timer_timeout() -> void:
	spawnPaper()
	setTimer()
