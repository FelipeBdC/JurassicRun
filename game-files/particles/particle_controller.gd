extends GPUParticles2D
class_name ParticleController


func _ready() -> void:
	Settings.settings_updated.connect(_on_settings_updated)
	_on_settings_updated()
	
	
func _on_settings_updated() -> void:
	emitting = Settings.get_setting("graphics", "particles")
