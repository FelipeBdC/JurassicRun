extends AnimationPlayer


signal sequence_finished
var loaded: bool = false
var anim_finished: bool = false


func _ready() -> void:
	animation_finished.connect(_on_animation_finished)


func _process(_delta: float) -> void:
	if not loaded or not anim_finished:
		return
	sequence_finished.emit()
	set_process(false)


func _on_loader_loaded() -> void:
	loaded = true
	
	
func _on_animation_finished(_anim_name) -> void:
	anim_finished = true
