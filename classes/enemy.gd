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
@export var duration_debuff: float

#Variaveis para controle de danos
var timer = Timer.new()
var damage: int = 0
var target = null
var duration = 0
var statusAntigos
signal healthChanged
var qtd_timer = 0

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
	pass

func criaTimer(time,type,duration):
	if type == "damageOverTime":
		var timer = Timer.new()
		add_child(timer)
		duration = duration
		timer.timeout.connect(Callable(self, "_on_timer_timeout"))
		timer.wait_time = time
		timer.start()
		
	
	
func damageOverTime(body, _damage, time):
	print("chegou no over")
	damage = _damage
	target = body
	duration += time
	criaTimer(1.0,"damageOverTime",duration)
func speed_reduction(body,reduction,time):
	print("chegou na reduçao")
	body.speed = reduction
	criaTimer(time,"SpeedReduction",time)
	
func _on_timer_timeout_debuffs():
	if target and duration:
		duration -= 0
		target = statusAntigos
	if duration == 0:
		timer.stop()
		target = null
		
	

func _on_timer_timeout() -> void:
	if target and duration and damage > 0:
		target.take_damage(damage)
		duration -= 1

	elif duration == 0:
		print("terminou")
		timer.stop()
		target = null
		damage = 0

func apply_status(target,effect_data):
	if effect_data.has("damage_over_time") and effect_data["damage_over_time"] != null:
		damageOverTime(target,effect_data["damage_over_time"],effect_data["effect_duration"])
	if effect_data.has("speed_reduction"):
		if effect_data["speed_reduction"] > 0:
			speed_reduction(target,effect_data["speed_reduction"],effect_data["effect_duration"])
		
		
