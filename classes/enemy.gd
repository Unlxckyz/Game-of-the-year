extends Node2D
class_name Enemy
@export var labelStatus = Label
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
@export var xingamentos = ["vai toma no cu porra", "vai se fuder","vai bate na mãe caralho","corno","viado","chupa cu"]

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
	print("Dano da spell: ", damage)
	currentHealth -= damage
	if currentHealth <= 0:
		queue_free()
	health_bar.health = currentHealth

func _process(delta: float) -> void:
	if not target:
		timer.stop()
func createTimer(time,type):
	if type == "dmgOverTime":
		add_child(timer)
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(1))
		timer.wait_time = time 
		timer.start()
	if type == "speed":
		add_child(timer)
		timer.timeout.connect(Callable(self, "_on_timer_timeout").bind(2))
		target.shoke()
		timer.wait_time = 1.0
		self.speed = 0
		target.showLabel("Paralyzed")
		timer.start()
		
		
	
func randomText(text):
	randomize()
	var indice_text = randi() % text.size()
	return text[indice_text]
	
func damageOverTime(_target,effect_data):
	damage = effect_data["damage_over_time"]
	target = _target
	duration += effect_data["effect_duration"]
	createTimer(1.0,"dmgOverTime")
func paralize(target,time):
	createTimer(time,"speed")

func _on_timer_timeout(int) -> void:
	if 1:
		if target and duration > 0:
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
	if effect_data["speed_reduction"] > 0:
		paralize(target,effect_data["speed_reduction"])
		
