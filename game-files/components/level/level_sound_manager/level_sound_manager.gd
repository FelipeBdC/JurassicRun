extends Node2D


@export_range(0, 100) var id: int = 0


func _ready() -> void:
	Game.play_sound_request.connect(play_sound)


func play_sound(manager_id: int, stream: AudioStream, bus: String, volume: float) -> void:
	if manager_id != id:
		return
	
	var new_sound_stream: AudioStreamPlayer = create_sound_stream()
	new_sound_stream.stream = stream
	new_sound_stream.bus = bus
	new_sound_stream.volume_db = linear_to_db(volume)
	new_sound_stream.play()
	
	
func create_sound_stream() -> AudioStreamPlayer:
	var new_sample: AudioStreamPlayer = AudioStreamPlayer.new()
	self.add_child(new_sample)
	new_sample.finished.connect(new_sample.queue_free)
	return new_sample
