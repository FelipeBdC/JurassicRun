extends Node2D


@export var spawner: Spawner
var obstacle_count: int = 0
@onready var original_spawn_delay: float = spawner.spawn_delay_max


func _on_spawner_node_spawned(_node: Node) -> void:
	var difficulty: float = get_difficulty()
	var spawn_delay = original_spawn_delay + difficulty
	spawn_delay = clamp(spawn_delay, 0.6, 2.0)
	
	if difficulty > 1.0: ## Easy
		spawner.spawn_delay_min = spawn_delay * 0.80
		spawner.spawn_delay_max = spawn_delay
	else:                ## Hard
		spawner.spawn_delay_min = spawn_delay
		spawner.spawn_delay_max = spawn_delay * 1.60
		
	obstacle_count += 1
	spawner.start_timer()
	
	
func get_difficulty() -> float:
	var difficulty: float = sin(obstacle_count)
	difficulty *= 1.5
	return difficulty
