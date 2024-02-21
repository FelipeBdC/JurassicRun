extends Node


@export var stream: AudioStream
@export_enum("Master", "SFX", "UI", "Music") var bus: String = "Master"
@export_range(0.0, 1.0) var volume: float = 1.0


func play_sound() -> void:
	if stream == null:
		push_warning("audio stream not provided")
		return
	
	Game.play_sound(0, stream, bus, volume)
