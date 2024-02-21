extends Area2D
class_name Hurtbox


signal hurt(damage)


func _ready() -> void:
	self.area_entered.connect(on_hitbox_entered)
	
	
func on_hitbox_entered(hitbox: Hitbox) -> void:
	hurt.emit(hitbox.damage)
