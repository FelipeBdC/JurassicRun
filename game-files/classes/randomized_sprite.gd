class_name RandomizedSprite
extends Sprite2D


@export var sprites: Array[Texture] = []


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	randomize()
	var texture_id: int = randi_range(0, len(sprites) - 1)
	self.texture = sprites[texture_id]
