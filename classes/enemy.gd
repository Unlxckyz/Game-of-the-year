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

signal healthChanged

func _ready() -> void:
	health_bar.init_health(maxHealth)
	currentHealth = maxHealth

func _process(delta: float) -> void:
	pass

func take_damage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		queue_free()
	health_bar.value = currentHealth
