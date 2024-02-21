extends Node


@export var duration_ms: int = 500


func vibrate() -> void:
	Input.vibrate_handheld(duration_ms)
