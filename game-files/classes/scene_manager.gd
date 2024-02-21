extends Node
class_name SceneManager


signal scene_changed
const OPAQUE: Color = Color(0.0, 0.0, 0.0, 1.0)
const TRANSPARENT: Color = Color(0.0, 0.0, 0.0, 0.0)
@export var default_scene: PackedScene
@export var scenes: Dictionary = {}
@export_category("Options")
@export var BlackOverlay: ColorRect
@export_range(0.0, 2.0) var fade_in_multiplier: float = 1.0
@export_range(0.0, 2.0) var fade_out_multiplier: float = 1.0
var fade_out_speed: float
var fade_in_speed: float
var current_scene_key: String


func _ready() -> void:
	Game.change_scene_request.connect(_on_change_scene_request)
	Game.reset_scene_request.connect(reset_scene)
	add_scene(default_scene)


func add_scene(scene_file: PackedScene) -> Node:
	var new_scene: Node = scene_file.instantiate()
	add_child(new_scene)
	return new_scene


func remove_scene() -> void:
	if get_child_count() == 0:
		return
	get_child(0).queue_free()


func reset_scene() -> void:
	remove_scene()
	add_scene(scenes[current_scene_key])
	
	
func swap_scenes(new_scene_file: PackedScene) -> void:
	remove_scene()
	add_scene(new_scene_file)
	

func swap_scenes_with_fading(new_scene_file: PackedScene) -> void:
	if not is_instance_valid(BlackOverlay):
		push_error("Black Overlay not valid.")
		return
	
	var tween: Tween = create_tween()
	var fading_speed: float
	
	# Fade In
	fading_speed = fade_in_speed * fade_in_multiplier	
	tween.tween_property(BlackOverlay, "color", OPAQUE, fading_speed)
		
	tween.tween_callback(remove_scene)
	tween.tween_callback(add_scene.bind(new_scene_file))
	
	# Fade Out
	fading_speed = fade_out_speed * fade_out_multiplier
	tween.tween_property(BlackOverlay, "color", TRANSPARENT, fading_speed)
	
	
func _on_change_scene_request(scene_name: String, fading: bool, fade_in: float, fade_out: float) -> void:
	if scenes.is_empty():
		push_error("No scenes given.")
		return
	if scene_name not in scenes.keys():
		push_error('Scene "%s" not registered.' % scene_name)
		return
		
	fade_in_speed = fade_in
	fade_out_speed = fade_out
	
	current_scene_key = scene_name
	
	if fading:
		swap_scenes_with_fading(scenes[scene_name])
		return
	swap_scenes(scenes[scene_name])
