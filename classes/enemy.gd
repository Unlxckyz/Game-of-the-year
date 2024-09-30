extends Node2D
class_name Enemy
@export var maxHealth : float
@export var currentHealth : float
@export var health_bar : HealthBar
@export var label_for_status: Label
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

func criaTimer(time,type):
	if type == "damageOverTime":
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(1))
		timer.wait_time = time
		timer.start()	
	elif type == "paralyze":
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(2))
		timer.wait_time = time
		self.speed = 0
		timer.one_shot = true
		timer.start()
		
		
	
	
func damageOverTime(body, _damage, time):
	print("chegou no over")
	damage = _damage
	target = body
	duration += time
	criaTimer(1.0,"damageOverTime")
func speed_reduction(body,reduction,time):
	print("chegou na reduçao")
	criaTimer(time,"paralyze")
	
	


func _on_timer_timeout(type) -> void:
	if type == 1:
		if target and duration and damage > 0:
			target.take_damage(damage)
			duration -= 1

	if duration == 0 and target:
		
		timer.stop()
		target.speed = 200
		target = null
		damage = 0
	if type == 2:
		self.speed = 50
	


func apply_status(target,effect_data):
	if effect_data.has("damage_over_time") and effect_data["damage_over_time"] != null:
		damageOverTime(target,effect_data["damage_over_time"],effect_data["effect_duration"])
	if effect_data.has("speed_reduction"):
		if effect_data["speed_reduction"] > 0:
			criaTimer(effect_data["effect_duration"],"paralyze")
		
