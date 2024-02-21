@tool
extends Button
class_name HoldButton


@onready var shader = preload("res://classes/hold_button/hold_button.tres")


func _ready() -> void:
	if Engine.is_editor_hint():
		if not self.material:
			self.material = shader.duplicate(true)

		set_process(false)
		set_physics_process(false)
		return
		

func _process(delta: float) -> void:
	var new_percentage = get_shader_parameter("percentage")
	
	if button_pressed:
		new_percentage += 0.2 * delta
	else:
		new_percentage = 0.0
	
	new_percentage = clamp(new_percentage, 0.0, 1.0)
	
	set_shader_parameter("percentage", new_percentage)
	
	
func set_shader_parameter(parameter: String, value) -> void:
	(material as ShaderMaterial).set_shader_parameter(parameter, value)
	
	
func get_shader_parameter(parameter: String):
	return (material as ShaderMaterial).get_shader_parameter(parameter)





