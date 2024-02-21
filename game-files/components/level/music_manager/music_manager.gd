extends Node


@export var streams: Array[AudioStream]
@export_category("Options")
@export var stream_id: int = 0
@export var randomize_song: bool = false
@export var autoplay: bool = true
@export var loop: bool = false
@export var max_volume: float = 1.0
@export_category("Script Settings")
@export var stream_player: AudioStreamPlayer
var music_volume: float = 0.0


func _ready() -> void:
	
	if streams.is_empty():
		return
	
	if autoplay:
		play_music()
		
		
func _process(_delta: float) -> void:
	stream_player.volume_db = linear_to_db(music_volume)


func play_music() -> void:
	var stream: AudioStream = get_track()
	stream_player.stream = stream
	stream_player.playing = true
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "music_volume", max_volume, 4.0)
	
	if loop and not stream_player.is_connected("finished", play_music):
		stream_player.finished.connect(play_music)
	
	
func get_track() -> AudioStream:
	if randomize_song:
		randomize()
		return streams[randi_range(0, len(streams) - 1)]
	return streams[stream_id]
