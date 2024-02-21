extends Node


signal cookies_not_allowed


func _ready() -> void:
	if not OS.is_userfs_persistent():
		cookies_not_allowed.emit()
