extends Button

var active = false
var flickerTime = 0.5 #0.5 seconds

var flickerTimer = Timer.new()

func activateFlicker():
	flickerTimer.start()

func deactivateFlicker():
	flickerTimer.stop()

func _ready() -> void:
	flickerTimer.wait_time = flickerTime
	flickerTimer.timeout.connect(flick)
	
	add_child(flickerTimer)

func flick():
	active = !active
	
	if active:
		theme_type_variation = "ButtonFileFlick"
	else:
		theme_type_variation = "ButtonFile"


func _on_button_down() -> void:
	deactivateFlicker()
	theme_type_variation = "ButtonFile"
