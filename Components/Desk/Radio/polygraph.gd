extends ColorRect

@onready var mat := material as ShaderMaterial

func _process(delta: float) -> void:
	mat.set_shader_parameter("time", Time.get_ticks_msec() / 1000.0)
