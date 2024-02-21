extends Node


@export var scene_name: String = ""
@export_category("Settings")
@export var fading: bool = true
@export var fade_in_speed: float = 1.0
@export var fade_out_speed: float = 1.0


func change_scene() -> void:
	Game.change_scene(scene_name, fading, fade_in_speed, fade_out_speed)
