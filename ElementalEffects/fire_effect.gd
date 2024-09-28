extends CPUParticles2D

var timer = Timer.new()
var damage: int = 0
var target = null
var duration: float = 0

func _ready():
	if target:
		add_child(timer)
		timer.timeout.connect(Callable(self, "_on_timer_timeout"))
		timer.wait_time = 1.0
		timer.start()
	
	
func _process(delta: float) -> void:
	if not target:
		timer.stop()
func damageOverTime(body, _damage, time):
	damage = _damage
	target = body
	duration = time
	

func _on_timer_timeout() -> void:
	if target and duration > 0:
		target.take_damage(damage)
		duration -= 1
		

	elif duration == 0:
		timer.stop()
		target = null  # Limpa o alvo após o término
