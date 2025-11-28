extends Node

class_name Difficulty

static var min_points := 1
static var max_points := 3

static var min_spawn_time := 10.0   # segundos
static var max_spawn_time := 35.0   # segundos

static func get_day_progress(elapsed: float, total: float) -> float:
	return clamp(elapsed / total, 0.0, 1.0)

static func get_day_factor(day: int) -> float:
	return clamp(float(GameManager.day - 1) / float(GameManager.maxDays - 1), 0.0, 1.0)

static func get_points_to_sync(day: int, elapsed: float, total: float) -> int:
	var p_day = get_day_factor(day)
	var p_time = get_day_progress(elapsed, total)

	var diff = (p_day * 0.5 + p_time * 0.5)

	return int(round(lerp(min_points, max_points, diff)))

static func get_spawn_time(day: int, elapsed: float, total: float) -> float:
	var p_day = get_day_factor(day)
	var p_time = get_day_progress(elapsed, total)

	var diff = (p_day * 0.5 + p_time * 0.5)

	return lerp(max_spawn_time, min_spawn_time, diff)
