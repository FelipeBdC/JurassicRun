extends Node


@export var button_click_sound: AudioStream
@export var special_button_click_sound: AudioStream


func _ready() -> void:
	connect_buttons()


func connect_buttons() -> void:
	for button in get_tree().get_nodes_in_group("buttons"):
		if button.is_connected("pressed", _on_button_pressed):
			continue
		button.pressed.connect(_on_button_pressed)
		
	for button in get_tree().get_nodes_in_group("special_buttons"):
		if button.is_connected("pressed", _on_special_button_pressed):
			continue
		button.pressed.connect(_on_special_button_pressed)
		
		
func _on_button_pressed() -> void:
	Game.play_sound(1, button_click_sound, "UI", 1.0)


func _on_special_button_pressed() -> void:
	Game.play_sound(1, special_button_click_sound, "UI", 1.0)
