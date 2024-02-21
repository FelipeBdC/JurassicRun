extends Area2D


var overlapping_areas: Array[Area2D] = []

var distances: Array[float] = []


func _process(_delta: float) -> void:
	if not has_overlapping_areas(): 
		if not distances.is_empty(): 
			distances.sort()
			if distances[0] < 20.0:
				GameEvents.player_performed_action.emit("risky_jump")
			print_debug("lowest distance was: %s" % distances[0])
			distances = []
		return
	
	overlapping_areas = get_overlapping_areas()
	
	var distance: float = global_position.distance_to(overlapping_areas[0].global_position)
	if distances.is_empty():
		distances.append(distance)
		return
	if distance != distances[len(distances) - 1]:
		distances.append(distance)
	
