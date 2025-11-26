extends ColorRect

@export var polygraph:ColorRect
@export var signalStatus:Control

var drag = false
var mouseOffset = Vector2(0,0)

var selectedPoint = []

func _process(_delta: float) -> void:
	if drag:
		var new_pos = get_global_mouse_position() - mouseOffset
		var maxSize = polygraph.get_rect().size
		
		new_pos.x = clamp(new_pos.x, 0.0, maxSize.x-get_rect().size.x)
		
		global_position.x = new_pos.x

func _on_button_button_down() -> void:
	drag = true
	mouseOffset = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	drag = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ReceiverPoint"):
		selectedPoint.append(area.get_parent())

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("ReceiverPoint"):
		var find = selectedPoint.find(area.get_parent())
		selectedPoint.remove_at(find)
