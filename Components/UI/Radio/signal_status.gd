extends Control

@onready var yes = $Yes
@onready var no = $No

func _ready() -> void:
	deactivate()

# Called when the node enters the scene tree for the first time.
func deactivate():
	yes.visible = false
	no.visible = false

func activateYes():
	yes.visible = true
	no.visible = false

func activateNo():
	yes.visible = false
	no.visible = true
