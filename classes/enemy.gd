extends Node2D
class_name Enemy

@export var health : float
@export var health_bar : HealthBar
@export var atk : float
@export var def : float
@export var hitbox : Area2D
@export var spells : Array[Spell]
@export var speed : float
@export var AI_behavior : Node
@export var level : int
@export var experience_points : int
@export var drop_items : Array[Item] = []
@export var is_boss : bool
@export var aggro_range : float
@export var resistances : Dictionary = {}
@export var damage_modifiers : Dictionary = {}
@export var animation_player : AnimationPlayer


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
