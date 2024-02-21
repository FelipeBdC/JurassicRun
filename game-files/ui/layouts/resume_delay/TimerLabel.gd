extends Label


@export var timer: Timer


func _process(_delta: float) -> void:
	var ceiled_time: float = ceil(timer.time_left)
	
	self.text = str(int(ceiled_time))
