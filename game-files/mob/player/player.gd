extends CharacterBody2D


signal velocity_updated(value: Vector2)
signal player_jumped()
signal player_landed()
@export var ground_check: RayCast2D
@export var jump_height: float = 10.0
@export var jump_time_to_peak: float = 1.0
@export var jump_time_to_fall: float = 1.0
var screen_rect: Rect2
var click_threshold: float
var jump_cut: bool = false
var previous_y_velocity: float = 0.0
@onready var jump_velocity: float = (2 * jump_height / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2 * jump_height) / (pow(jump_time_to_peak, 2.0))) * -1
@onready var jump_fall_gravity: float = ((-2 * jump_height) / (pow(jump_time_to_fall, 2.0))) * -1
@onready var small_jump_gravity: float = jump_gravity * 1.7
@onready var small_jump_fall_gravity: float = jump_fall_gravity * 1.6


func _ready() -> void:
	screen_rect = get_viewport_rect()
	click_threshold = screen_rect.size.y - (screen_rect.size.y * 0.05)


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton and not event is InputEventKey:
		return
	if is_invalid_input(event):
		return
	if not (event.is_action_pressed("action_jump")):
		if velocity.y < 0.0:
			jump_cut = true
		return
	if not (ground_check.is_colliding()):
		return

	velocity.y = jump_velocity
	player_jumped.emit()


func _process(_delta) -> void:
	if previous_y_velocity > 0.0 and velocity.y == 0.0:
		player_landed.emit()


func _physics_process(delta: float) -> void:
	if ground_check.is_colliding():
		jump_cut = false
		
	velocity_updated.emit(velocity)
	
	previous_y_velocity = velocity.y
	velocity.y += get_gravity() * delta
	move_and_slide()
	
	
func get_gravity() -> float:
	var gravity: float = jump_gravity
	
	gravity = jump_gravity if velocity.y < 0.0 else jump_fall_gravity
	if jump_cut:
		gravity = small_jump_gravity if velocity.y < 0.0 else small_jump_fall_gravity
	
	return gravity
	
	
func is_invalid_input(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		if event.get_position().y > click_threshold:
			return true
	
	return false
