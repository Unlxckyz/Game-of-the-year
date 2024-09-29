extends Node2D
class_name Enemy

@export var maxHealth : float
@export var currentHealth : float
@export var health_bar : HealthBar
@export var atk : float
@export var damage_modifiers : Dictionary = {}
@export var def : float
@export var level : int
@export var speed : float
@export var resistances : Dictionary = {}
@export var spells : Array[Spell] = []
@export var aggro_range : float
@export var hitbox : Area2D
@export var AI_behavior : Node
@export var experience_points : int
@export var drop_items : Array[Item] = []
@export var is_boss : bool
@export var is_elite: bool
@export var animation_player : AnimationPlayer

#Variaveis para controle de danos
var timer = Timer.new()
var damage: int = 0
var target = null
var duration: float = 0
signal healthChanged

func _ready() -> void:
	health_bar.init_health(maxHealth)
	currentHealth = maxHealth
	#Se ele é target
	
		


func take_damage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		queue_free()
	print(damage)
	health_bar.health = currentHealth

func _process(delta: float) -> void:
	if not target:
		timer.stop()

func damageOverTime(body, _damage, time):
	print("chegou no over")
	damage = _damage
	target = body
	duration = time
	add_child(timer)
	timer.timeout.connect(Callable(self, "_on_timer_timeout"))
	timer.wait_time = 1.0
	timer.start()
	

func _on_timer_timeout() -> void:
	print("ta dando damage por segundo")
	if target and duration > 0:
		target.take_damage(damage)
		duration -= 1
		

	elif duration == 0:
		timer.stop()
		target = null  # Limpa o alvo após o término
