extends Node2D


const DEFAULT_PROCESS_MODE = PROCESS_MODE_PAUSABLE


func _on_ready() -> void:
	Game.pause_level_request.connect(pause_level)
	Game.unpause_level_request.connect(resume_level)
	pause_level.call_deferred()


func start_game() -> void:
	resume_level()


func end_game() -> void:
	Game.reset_scene()


func pause_level() -> void:
	if get_child_count() == 0:
		return
	get_child(0).set_process_mode.call_deferred(PROCESS_MODE_DISABLED)


func resume_level() -> void:
	if get_child_count() == 0:
		return
	get_child(0).process_mode = DEFAULT_PROCESS_MODE
