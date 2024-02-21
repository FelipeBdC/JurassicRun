extends Node2D
class_name Spawner


signal node_spawned(node: Node)
@export_category("Node Settings")
@export var node_scenes: Array[PackedScene]
@export var parent_node: Node2D = self
@export_category("Spawning Settings")
@export var disabled: bool = false
@export var spawn_delay_min: float = 1.0
@export var spawn_delay_max: float = 1.0
@export_category("Timer Settings")
@export var one_shot: bool = true
@export var autostart: bool = true
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.one_shot = one_shot
	if autostart:
		timer.start(spawn_delay_min)
	
	
func spawn_node() -> void:
	if disabled:
		return
	
	randomize()
	var node_id: int = randi_range(0, len(node_scenes) - 1)
	
	var node_instance: Node2D = node_scenes[node_id].instantiate()
	parent_node.add_child(node_instance)
	node_instance.set_global_position(parent_node.global_position)
	node_spawned.emit(node_instance)
	
	
func start_timer() -> void:
	randomize()
	var spawn_delay: float = randf_range(spawn_delay_min, spawn_delay_max)
	timer.start(spawn_delay)
	
	
func _on_timer_timeout() -> void:
	spawn_node()
	if not one_shot:
		start_timer()
