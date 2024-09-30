extends Spell


func _ready():
	base_damage = 10
	speed = 100
	cooldown_time = 1.0
	knockback_force = 200.0
	effect_duration = 0.5
	elemental_type = "electric"




func _on_eletric_body_entered(body: Node2D) -> void:
	checkColide(body)
