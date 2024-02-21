extends Label


const FIRST_SCORE_TARGET = 100
@export var animation_player: AnimationPlayer
var score_target: int = 0
var common_difference: int = 200


func _ready() -> void:
	GameEvents.score_updated.connect(_on_score_updated)
	
	
func _on_score_updated(score: int) -> void:
	if score == Save.get_save_data("highscore") and score > 0:
		animation_player.play("reach_highscore")
	elif score == score_target or score == FIRST_SCORE_TARGET:
		animation_player.play("blink")
		score_target += common_difference
		
	if score_target == 1000:
		common_difference = 500
	
	self.text = str(score)
