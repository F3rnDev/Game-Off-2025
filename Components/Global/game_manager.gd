extends Node
class_name GameManager

static var day = 0
static var dayMerits = 0
static var dayDemerits = 0

enum DayStatus
{
	STOPPED,
	RUNNING,
	OVER
}

static var curDayStatus:DayStatus = DayStatus.STOPPED

static var hours: int = 12
static var minutes: int = 0

static var GAME_HOURS_DURATION = 7
static var START_HOUR = 12

static func resetDayMerits():
	dayMerits = 0
	dayDemerits = 0

static func setDayStatus(value:DayStatus):
	curDayStatus = value

static func setTime(elapsed_seconds: float, total_seconds: float) -> void:
	var fraction := 0.0
	if total_seconds > 0.0:
		fraction = clamp(elapsed_seconds / total_seconds, 0.0, 1.0)

	var total_game_minutes = GAME_HOURS_DURATION * 60
	var elapsed_game_minutes = fraction * total_game_minutes

	var start_minutes = START_HOUR * 60
	var current_minutes = int(floor(start_minutes + elapsed_game_minutes))

	hours = int(current_minutes / 60) % 24
	minutes = current_minutes % 60
