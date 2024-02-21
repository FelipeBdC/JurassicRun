extends Control
class_name MaxSizeContainer


@export var max_size: Vector2 = Vector2.ZERO
@export var original_size: Vector2
var original_position: Vector2
var screen_size: Vector2
var half_screen_height: float = screen_size.y * 0.5
@onready var half_control_height: float = original_size.y * 0.5



func _ready() -> void:
	original_position = position
	get_tree().get_root().size_changed.connect(update_sizes)
	update_sizes()
	
	
func update_sizes() -> void:
	var new_size: Vector2 = size	
	new_size.x = max_size.x if size.x > max_size.x else original_size.x
	new_size.y = max_size.y if size.y > max_size.y else original_size.y
	
	var new_position: Vector2 = original_position
	if new_size.x == max_size.x:
		new_position.x = original_size.x - max_size.x
	if new_size.y == max_size.y:
		screen_size = get_viewport_rect().size
		half_screen_height = screen_size.y * 0.5
		new_position.y = half_screen_height - half_control_height
	
	set_deferred("position", new_position)
	set_deferred("size", new_size)
