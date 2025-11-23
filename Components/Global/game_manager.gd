extends Node
class_name GameManager

static var hours: int = 12
static var minutes: int = 0

static var GAME_HOURS_DURATION = 7
static var START_HOUR = 12

static func setTime(elapsed_seconds: float, total_seconds: float) -> void:
	# fração do período (0..1)
	var fraction := 0.0
	if total_seconds > 0.0:
		fraction = clamp(elapsed_seconds / total_seconds, 0.0, 1.0)

	# total de minutos simulados para o período (7 horas = 420 minutos)
	var total_game_minutes = GAME_HOURS_DURATION * 60
	var elapsed_game_minutes = fraction * total_game_minutes

	var start_minutes = START_HOUR * 60
	var current_minutes = int(floor(start_minutes + elapsed_game_minutes))

	hours = int(current_minutes / 60) % 24
	minutes = current_minutes % 60
