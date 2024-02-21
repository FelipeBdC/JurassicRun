extends Node


signal change_scene_request(scene_name: String, fading: bool, fade_in: float, fade_out: float)
signal reset_scene_request()
signal change_ui_request(interface_name: String, fading: bool, fade_in: float, fade_out: float)
signal emit_particle_request(particle_scene_file: PackedScene, particle_position: Vector2)
signal play_sound_request(manager_id: int, stream: AudioStream, bus: String, volume: float)
signal pause_level_request()
signal unpause_level_request()

var score: int = 0


func pause_game() -> void:
	pause_nodes()
	get_tree().paused = true

	
func unpause_game() -> void:
	get_tree().paused = false
	unpause_nodes()
	
	
func pause_level() -> void:
	pause_nodes()
	pause_level_request.emit()
	
	
func unpause_level() -> void:
	unpause_nodes()
	unpause_level_request.emit()

	
func reset_scene() -> void:
	reset_scene_request.emit()
	
	
func emit_particle(particle_scene_file: PackedScene, particle_position: Vector2) -> void:
	emit_particle_request.emit(particle_scene_file, particle_position)
	
	
func change_scene(scene_name: String, fading: bool, fade_in: float, fade_out: float) -> void:
	change_scene_request.emit(scene_name, fading, fade_in, fade_out)
	
	
func change_ui(interface_name: String, fading: bool, fade_in: float, fade_out: float) -> void:
	change_ui_request.emit(interface_name, fading, fade_in, fade_out)
	
	
func play_sound(manager_id: int, stream: AudioStream, bus: String, volume: float = 1.0) -> void:
	play_sound_request.emit(manager_id, stream, bus, volume)
	
	
	
func pause_nodes() -> void:
	for node in get_tree().get_nodes_in_group("pausables"):
		node.process_mode = PROCESS_MODE_DISABLED
		
func unpause_nodes() -> void:
	for node in get_tree().get_nodes_in_group("pausables"):
		node.process_mode = PROCESS_MODE_PAUSABLE
