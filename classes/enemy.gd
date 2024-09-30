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
var label = Label.new()
var timer = Timer.new()
var damage: int = 0
var target = null
var duration: float = 0
signal healthChanged

func _ready() -> void:
	health_bar.init_health(maxHealth)
	currentHealth = maxHealth
	#Se ele é target
	
func showStatus(text,time):
	self.label.text = text
	criaTimer(time,null,true)

	
func take_damage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		queue_free()
	print(damage)
	health_bar.health = currentHealth

func _process(delta: float) -> void:
	if not target:
		timer.stop()
func criaTimer(time,type = null,loop = true):
	add_child(timer)
	timer.wait_time = time
	if type == "dmgOverTime":
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(1))
		self.showStatus("Queimando",1.0)
		
	if "speed":
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(2))
		timer.one_shot = true
		self.speed = 0
	timer.start()
		
		
	
	
func damageOverTime(_target,effect_data):
	print("chegou no over")
	damage = effect_data["damage_over_time"]
	target = _target
	duration += effect_data["effect_duration"]
	criaTimer(1.0,"dmgOverTime")
func paralize(target,time):
	print("paralizou")
	criaTimer(time,"speed",false)

func _on_timer_timeout(int) -> void:
	if 1:
		if target and duration > 0:
			print("chegou aq")
			target.label.text("Queimando")
			target.take_damage(damage)
			duration -= 1
		

		elif duration == 0:
			timer.stop()
			target = null  # Limpa o alvo após o término
	if 2:
		self.speed = 50	
func apply_status(target,effect_data):
	if effect_data.has("damage_over_time"):
		damageOverTime(target,effect_data)
