extends Node


signal event_received(args: Array)
@export_enum("ui_events", "hud_events", "game_events") var event_type: String = "ui_events"
@export var event_name: String
@onready var event_singletons: Dictionary = {
	"ui_events": UIEvents,
	"hud_events": HUDEvents,
	"game_events": GameEvents
}


func _ready() -> void:
	var singleton = event_singletons[event_type]
	singleton.get(event_name).connect(_on_event_triggered)
	
	
func _on_event_triggered(args: Array) -> void:
	event_received.emit(args)
