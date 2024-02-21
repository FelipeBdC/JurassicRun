@tool
extends Sprite2D
class_name ScrollingTexture


@export var scrolling: bool = false
@export var speed: float = 1.0
var scroll_amount: float = 0.0
@onready var shader = preload("res://materials/scrolling_texture.tres")


func _ready() -> void:
	if Engine.is_editor_hint():
		if not self.material:
			self.material = shader.duplicate(true)

		set_process(false)
		set_physics_process(false)
		return
	
	set_shader_parameter("scroll", scrolling)	
	set_shader_parameter("speed", speed)
	scroll_amount = get_shader_parameter("scroll_amount")
		

func _process(delta: float) -> void:
	if not scrolling:
		return
		
	scroll_amount += delta
	set_shader_parameter("scroll_amount", scroll_amount)
	
	
func set_shader_parameter(parameter: String, value) -> void:
	(material as ShaderMaterial).set_shader_parameter(parameter, value)
	
	
func get_shader_parameter(parameter: String):
	return (material as ShaderMaterial).get_shader_parameter(parameter)





