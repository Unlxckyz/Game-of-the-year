extends Spell

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	base_damage = 20
	speed = 200
	cooldown_time = 0.5
	effect_duration = 0.5
	elemental_type = "fire"





func _on_area_2d_body_entered(body: Node2D) -> void:
	checkColide(body)
