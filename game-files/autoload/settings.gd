extends Node


signal settings_updated()
var save_path: String = "user://settings.cfg"
var config_file: ConfigFile = ConfigFile.new()
var load_response = config_file.load(save_path)

enum {
	MASTER,
	SFX,
	UI,
	MUSIC
}

var settings: Dictionary = {
	"audio": {
		"master": 1.0,
		"sfx": 1.0,
		"ui": 1.0,
		"music": 1.0
	},
	"graphics": {
		"particles": true,
		"show_hud": true
	}
}


func _ready() -> void:
	match load_response:
		OK:
			load_settings()
		ERR_FILE_NOT_FOUND:
			save_settings()


func setup_settings() -> void:
	set_bus_volume(MASTER, "master")
	set_bus_volume(SFX, "sfx")
	set_bus_volume(UI, "ui")
	set_bus_volume(MUSIC, "music")
			
	
func load_settings() -> void:
	for section in config_file.get_sections():
		for key in config_file.get_section_keys(section):
			if not key in settings[section].keys():
				continue
			settings[section][key] = config_file.get_value(section, key)
	setup_settings()
	

func save_settings() -> void:
	for section in settings.keys():
		for key in settings[section].keys():
			config_file.set_value(section, key, settings[section][key])
	config_file.save(save_path)
	setup_settings()
	

func change_setting(section: String, key: String, value) -> void:
	settings[section][key] = value
	save_settings()
	settings_updated.emit()
	
	
func get_setting(section: String, key: String):
	return settings[section][key]


func set_bus_volume(bus_id: int, key: String) -> void:
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(settings["audio"][key]))
