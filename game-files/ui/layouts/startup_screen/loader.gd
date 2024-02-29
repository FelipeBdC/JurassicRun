extends Node


signal loaded

@export_file("*.tscn") var file_path: String
var loading_status: int
var progress: Array[float]


func _ready() -> void:
	if file_path.is_empty():
		return
	
	ResourceLoader.load_threaded_request(file_path)
	

func _process(_delta) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(file_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print_debug("loading %%s" % [progress[0]])
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded.emit()
			print_debug("loaded")
			set_process(false)
	
