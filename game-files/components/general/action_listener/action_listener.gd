extends Node


signal action_pressed
@export var action_name: String
@export var detect_once: bool = false
@export var detection_delay: float = 0.0
var detected: bool = false


func _ready() -> void:
	set_process_unhandled_input(false)
	await get_tree().create_timer(detection_delay).timeout
	set_process_unhandled_input(true)


func _unhandled_input(event):
	if detected:
		return
	
	if event.is_action_pressed(action_name):
		action_pressed.emit()
		detected = detect_once
