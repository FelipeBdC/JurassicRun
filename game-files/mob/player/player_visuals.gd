extends Sprite2D


@export var animation_player: AnimationPlayer

var dead: bool = false


func _ready() -> void:
	UIEvents.play_button_pressed.connect(play_run_animation)


func play_run_animation(_args) -> void:
	animation_player.play("run")


func _on_player_velocity_updated(value: Vector2) -> void:
	if dead:
		return
	
	var y_velocity: float = value.y
	
	if y_velocity == 0.0:
		animation_player.play("run")
		return
	if y_velocity < 0.0:
		animation_player.play("jump_stage_0")
	elif y_velocity > 0.0:
		animation_player.play("jump_stage_1")
	


func _on_hurtbox_hurt(_damage: Variant) -> void:
	dead = true
	animation_player.play("die")
