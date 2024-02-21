extends Node2D


@export var particle_scene: PackedScene


func emit() -> void:
	Game.emit_particle(particle_scene, self.global_position)
