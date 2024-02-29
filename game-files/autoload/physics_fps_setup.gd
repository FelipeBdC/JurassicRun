extends Node


func _ready(): 
	var refresh_rate: float = DisplayServer.screen_get_refresh_rate()
	if refresh_rate <= 0.0:
		refresh_rate = 60.0
	Engine.physics_ticks_per_second = int(refresh_rate)
