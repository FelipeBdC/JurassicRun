extends StaticBody2D


@export var sprite_1: Sprite2D
@export var sprite_2: Sprite2D
var speed: float = 140
var window_size: Vector2
var sprite_size: Vector2
@onready var sprites: Array[Sprite2D] = [sprite_1, sprite_2]


func _ready() -> void:
	window_size = get_viewport_rect().size
	sprite_size = sprite_1.get_rect().size


func _physics_process(delta: float) -> void:
	sprite_1.global_position.x -= speed * delta
	sprite_2.global_position.x -= speed * delta
	
	for sprite in sprites:
		if sprite.global_position.x < -sprite_size.x:
			sprite.global_position.x = window_size.x
