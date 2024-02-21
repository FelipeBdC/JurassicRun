extends Button
class_name SinglePressButton


func _ready() -> void:
	pressed.connect(_on_pressed)
	

func _on_pressed() -> void:
	disabled = true
