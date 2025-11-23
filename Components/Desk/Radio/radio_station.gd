extends Node2D

@onready var polygraph = $Radio/Control/TextureRect
@onready var reader = $Reader
@onready var radio = $Radio

@export var radioUi:RadioUI
@export var radioViewport:Viewport

var curRecvr:Array[Receiver] = []

var min_dist = 5.0
var max_points = 5

func _ready() -> void:
	setRadioVisor()

func setRadioVisor():
	polygraph.texture = radioViewport.get_texture()

func getPaperInPos():
	return $"Paper InPos".global_position

func getInfo(recvr):
	radioUi.updateRadio(recvr)

func setItem(active):
	var width = 1.0 if active else 0.0
	reader.material.set("shader_parameter/width",width);

func _on_button_mouse_entered() -> void:
	radio.material.set("shader_parameter/width",1.0);

func _on_button_mouse_exited() -> void:
	radio.material.set("shader_parameter/width",0.0);

func _on_button_button_down() -> void:
	get_parent().showRadio()
