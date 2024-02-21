extends Node


const direction_reset_speed = 40
@export var speed: int = 20
@export var gravity: float = 30
@export var target: CharacterBody2D
@export var ground_check: RayCast2D
var direction_vector: Vector2:
	set = set_direction_vector
var jump: float:
	set = set_jump


func _ready() -> void:
	if not is_instance_valid(target):
		push_error("target is invalid.")
		set_physics_process(false)
		return


func _physics_process(delta: float) -> void:
	if ground_check.is_colliding():
		direction_vector.y = gravity - jump
	else:
		direction_vector.y += gravity * delta
		jump = 0
	target.velocity = direction_vector * speed
	target.move_and_slide()
	
	
func set_direction_vector(value: Vector2) -> void:
	direction_vector = value
	

func set_jump(value: int) -> void:
	jump = value
