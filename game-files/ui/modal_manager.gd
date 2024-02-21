extends Control


@export var modals: Dictionary = {}


func _ready() -> void:
	open_modal("settings_menu")


func add_modal(modal_file: PackedScene) -> void:
	var new_modal: Control = modal_file.instantiate()
	add_child(new_modal)
	
	
func remove_modal() -> void:
	get_child(0).queue_free()
	
	
func open_modal(modal_name: String) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_modal(modals[modal_name])
	
