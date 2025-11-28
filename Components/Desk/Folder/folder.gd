extends Sprite2D

@export var pause:Control

func setItem(active):
	var width = 1.0 if active else 0.0
	material.set("shader_parameter/width",width)

func _on_button_mouse_entered() -> void:
	setItem(true)

func _on_button_mouse_exited() -> void:
	setItem(false)

func _on_button_button_down() -> void:
	pause.togglePause()
