extends MaxSizeContainer


func _ready() -> void:
	var hud_visible: bool = Settings.get_setting("graphics", "show_hud")
	self.visible = hud_visible
