extends Node


@export var score_timer: Timer


func _ready() -> void:
	Game.score = 0


func _on_score_timer_timeout() -> void:
	add_score(1)
	
	
func add_score(value: int) -> void:
	Game.score += value
	GameEvents.score_updated.emit(Game.score)
