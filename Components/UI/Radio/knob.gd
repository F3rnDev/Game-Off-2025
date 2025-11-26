extends Sprite2D

@export var status:Control
@export var slider:ColorRect

var drag = false
var target_angle = null

func _process(_delta: float) -> void:
	if drag:
		var ang = get_global_mouse_position().angle_to_point(global_position) - PI/2
		rotation = ang
	
	if slider.selectedPoint.size() > 0:
		status.activateNo()
		target_angle = slider.selectedPoint[0].desiredAngle
	else:
		status.deactivate()
		target_angle = null
	
	if is_in_target():
		status.activateYes()

func _on_button_button_down() -> void:
	drag = true

func _on_button_button_up() -> void:
	drag = false

func is_in_target(threshold_degrees := 5.0) -> bool:
	if target_angle == null:
		return false
	
	var diff = abs(angle_difference(rotation, target_angle))
	return diff <= deg_to_rad(threshold_degrees)
