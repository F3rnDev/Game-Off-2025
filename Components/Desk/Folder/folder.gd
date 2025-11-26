extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setItem(active):
	var width = 1.0 if active else 0.0
	material.set("shader_parameter/width",width)

func _on_button_mouse_entered() -> void:
	setItem(true)

func _on_button_mouse_exited() -> void:
	setItem(false)
