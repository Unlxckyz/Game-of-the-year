extends Spell


func _ready():
	base_damage = 10
	speed = 100
	damage_over_time = 5
	cooldown_time = 1.0
	knockback_force = 200.0
	effect_duration = 0.6
	elemental_type = "eletric"


func _on_eletric_body_entered(body):
	checkColide(body)
