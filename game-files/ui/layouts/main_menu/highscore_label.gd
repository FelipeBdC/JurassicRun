extends Label


@export var red_theme: Theme
@export var panel: PanelContainer


func _ready() -> void:
	self.text = str(Save.get_save_data("highscore"))
	
	
func cookies_not_allowed() -> void:
	panel.set_theme(red_theme)
	self.text = "COOKIES NOT ALLOWED"
