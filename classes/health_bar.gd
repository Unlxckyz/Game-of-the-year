extends ProgressBar
class_name HealthBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0 : set = _set_health

func init_health(initialHealth):
	max_value = initialHealth
	value = initialHealth
	damage_bar.max_value = initialHealth
	damage_bar.value = initialHealth

func _set_health(new_health):
	var previous_health = health
	
	health = min(max_value, new_health)
	
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < previous_health:
		timer.start()

func _on_timer_timeout() -> void:
	damage_bar.value = health
