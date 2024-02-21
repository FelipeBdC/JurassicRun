extends HSlider


@export_enum("Master", "SFX", "UI", "Music") var bus: String = "Master"
@export_category("Script")


func _ready() -> void:
	value_changed.connect(_on_value_changed)
	bus = bus.to_lower()
	load_value()		
	
	
func load_value() -> void:
	var new_value: float = Settings.get_setting("audio", bus)
	set_value.call_deferred(new_value)
	
	
func _on_value_changed(new_value: float) -> void:
	Settings.change_setting("audio", bus, new_value)
