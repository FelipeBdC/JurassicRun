extends MaxSizeContainer


var highscore: int = Save.get_save_data("highscore")


func _on_ready() -> void:
	if Game.score <= highscore:
		return
		
	Save.change_save_data("highscore", Game.score)
	Save.save_game()
