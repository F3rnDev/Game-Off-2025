extends Sprite2D

@export var status:Control
@export var slider:ColorRect
@export var polygraph:ColorRect

@export var min_amp := 2.0
@export var max_amp := 30.0
var target_amp := 10.0
var current_amp := 0.0
var smoothing := 6.0 

var drag = false
var target_angle = null

#static Audio
@export var radioAudio:AudioStreamPlayer
@export var minPitch = 0.8
@export var maxPitch = 1.1
var targetPitch = 1.0

func _process(delta: float) -> void:
	if drag:
		var ang = get_global_mouse_position().angle_to_point(global_position) - PI/2
		rotation = ang
		
		var norm = fmod(rotation, TAU)
		if norm < 0.0:
			norm += TAU

		# 0..1
		var knob01 = norm / TAU
		
		target_amp = lerp(min_amp, max_amp, knob01)
		targetPitch = lerp(minPitch, maxPitch, knob01)
	
	current_amp = lerp(current_amp, target_amp, delta * smoothing)
	polygraph.material.set_shader_parameter("amplitude", current_amp)
	
	radioAudio.pitch_scale = lerp(radioAudio.pitch_scale, targetPitch, delta * smoothing)
	
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
