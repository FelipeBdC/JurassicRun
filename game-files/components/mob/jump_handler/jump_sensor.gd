extends Node

signal jump_updated(jump: float)

const DEFAULT_JUMP_MULTIPLIER: float = 0.8
@export var jump_strength: float = 40
@export var ground_check: RayCast2D
var jump: float
var jump_multiplier: float = DEFAULT_JUMP_MULTIPLIER
var jump_button_pressed: bool = false
		
		
func _ready() -> void:
	if not is_instance_valid(ground_check):
		push_error("ground_check is invalid.")
		set_process_unhandled_input(false)
		return
		
		
func _process(delta: float) -> void:
	if jump_button_pressed:
		jump_multiplier += delta
		jump_multiplier = clamp(jump_multiplier, DEFAULT_JUMP_MULTIPLIER, 1)
		jump = jump_strength * jump_multiplier
		jump_updated.emit(jump)
		
		
func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey and not event is InputEventMouseButton:
		return
		
	if not ground_check.is_colliding():   
		return
		
	jump_multiplier = DEFAULT_JUMP_MULTIPLIER
		
	if not event.is_action_pressed("action_jump"):
		jump_button_pressed = false
		return
		
	jump_button_pressed = true
