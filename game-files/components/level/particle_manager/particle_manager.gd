extends Node2D


func _ready() -> void:
	Game.emit_particle_request.connect(emit_particle)


func emit_particle(particle_scene_file: PackedScene, particle_position: Vector2) -> void:
	if Settings.get_setting("graphics", "particles") == false:
		return
	
	var new_particle = add_particle(particle_scene_file)
	new_particle.emitting = true
	new_particle.global_position = particle_position
	
	
func add_particle(particle_scene_file: PackedScene) -> Node:
	var particle_instance = particle_scene_file.instantiate()
	add_child(particle_instance)
	return particle_instance
