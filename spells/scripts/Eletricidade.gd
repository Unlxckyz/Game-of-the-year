extends Spell


func _ready():
	base_damage = 10
	speed = 100
	damage_over_time = 5
	cooldown_time = 1.0
	knockback_force = 20.0


func _on_eletric_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(base_damage)
