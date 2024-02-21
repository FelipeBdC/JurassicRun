extends Control

const OPAQUE: Color = Color(1.0, 1.0, 1.0, 1.0)
signal ui_changed()
@export var startup_interface: PackedScene
@export var interfaces: Dictionary = {}
@export_category("Options")
@export_range(0.0, 2.0) var fade_in_multiplier: float = 1.0
@export_range(0.0, 2.0) var fade_out_multiplier: float = 1.0
@export_category("Script")
@export var current_interface_container: Control
var fade_out_speed: float
var fade_in_speed: float


func _ready() -> void:
	Game.change_ui_request.connect(_on_change_ui_request)
	add_interface(startup_interface)
	
	
func add_interface(interface: PackedScene) -> Control:
	var new_interface: Node = interface.instantiate()
	current_interface_container.add_child(new_interface)
	return new_interface
	
	
func remove_interface() -> void:
	current_interface_container.get_child(0).queue_free()
	

func swap_interfaces_with_fading(new_interface_file: PackedScene) -> void:
	var tween: Tween = create_tween()
	var current_interface: Control = current_interface_container.get_child(0)
	
	# Fade Out
	var fading_speed: float = fade_out_speed * fade_out_multiplier	
	tween.tween_property(current_interface, "modulate", Color.TRANSPARENT, fading_speed)
	tween.tween_callback(remove_interface)
	
	var new_interface = add_interface(new_interface_file)
	
	# Fade In
	fading_speed = fade_in_speed * fade_in_multiplier	
	new_interface.modulate = Color.TRANSPARENT
	tween.tween_property(new_interface, "modulate", OPAQUE, fading_speed)
	
	
	
func swap_interfaces(new_interface_file: PackedScene) -> void:
	remove_interface()
	add_interface(new_interface_file)
	

func _on_change_ui_request(interface_name: String, fading: bool, fade_in: float, fade_out: float) -> void:
	if interfaces.is_empty():
		push_error("No interfaces given.")
		return
	if interface_name not in interfaces.keys():
		push_error('Interface "%s" not registered.' % interface_name)
		return
		
	fade_in_speed = fade_in
	fade_out_speed = fade_out
	
	if fading:
		swap_interfaces_with_fading(interfaces[interface_name])
		ui_changed.emit()
		return
		
	swap_interfaces(interfaces[interface_name])
	ui_changed.emit()
	
	
	

