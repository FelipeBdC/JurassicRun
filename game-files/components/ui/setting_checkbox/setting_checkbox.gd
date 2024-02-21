extends CheckButton


@export_category("Setting Configuration")
@export var section: String
@export var key: String


func _ready() -> void:
	toggled.connect(_on_toggled)
	self.button_pressed = Settings.get_setting(section, key)
	
	
func _on_toggled(toggled_on: bool) -> void:
	Settings.change_setting(section, key, toggled_on)
