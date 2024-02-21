extends Node


@export var target: Node
@export var speed: int = 10
@export var direction: Vector2


func _ready() -> void:
	if not is_instance_valid(target):
		push_error("Target is invalid.")
		set_physics_process(false)
		return


func _physics_process(delta: float) -> void:
	target.position.x += speed * direction.x * delta
	target.position.y += speed * direction.y * delta
