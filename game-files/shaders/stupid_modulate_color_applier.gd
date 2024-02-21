@tool
extends TextureRect


@export var modulation_target: Node = self


func _process(delta: float) -> void:
	set_shader_parameter("modulate", modulation_target.modulate)
	
	
func set_shader_parameter(parameter: String, value) -> void:
	(material as ShaderMaterial).set_shader_parameter(parameter, value)
