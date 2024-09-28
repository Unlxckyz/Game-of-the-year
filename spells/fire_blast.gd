extends Spell

func _init() -> void:
	base_damage = 10
	speed = 200
	cooldown_time = 0.5
	damage_over_time = 1.0
	effect_duration = 10.0
	elemental_type = "fire"

func _on_area_2d_body_entered(body: Node2D) -> void:
	checkColide(body)
