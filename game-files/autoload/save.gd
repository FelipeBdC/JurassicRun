extends Node


var json: JSON = JSON.new()
var data: Dictionary = {
	"highscore": 0
}


func _ready() -> void:
	load_game()
	
	
func save_game() -> void:
	var save_file: FileAccess = FileAccess.open("user://game_data.save", FileAccess.WRITE)
	var json_string: String = JSON.stringify(data)
	save_file.store_line(json_string)
	save_file.close()	
	
func load_game() -> void:
	if not FileAccess.file_exists("user://game_data.save"):
		save_game()
		return
		
	var save_file: FileAccess = FileAccess.open("user://game_data.save", FileAccess.READ)
	var json_string: String = save_file.get_line()
	var parse_result = json.parse(json_string)
	
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		save_file.close()
		return
		
	data = json.get_data()
	save_file.close()
	
	
func change_save_data(key, value) -> void:
	data[key] = value
	

func get_save_data(key: String):
	return data[key]
	
