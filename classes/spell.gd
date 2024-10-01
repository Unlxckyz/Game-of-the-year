extends Node2D
class_name Spell

@export var spell_level: int
@export var speed: float
@export var direction: Vector2
@export var base_damage: int
@export var range: float
@export var mana_cost: int
@export var cooldown_time: float
@export var elemental_type: String
@export var effect_duration: float
@export var has_area_of_effect: bool
@export var can_pierce: bool
@export var knockback_force: float
@export var damage_over_time: int
@export var heal_amount: int
@onready var electric_preload = preload("res://ElementalEffects/electric_effect.tscn")
@onready var fire_preload = preload("res://ElementalEffects/fire_effect.tscn")


func _process(delta: float) -> void:
	position += direction.normalized() * delta * speed

func checkColide(body):
	if body.is_in_group("Enemy"):
		if body.has_method("take_damage"):
			body.take_damage(base_damage)
			if knockback_force:
				apply_knockback_force(body)
			body.animation.play("hurt")
			if elemental_type:
				apply_elemental_effect(body,elemental_type)
			#aqui é adicionado por exemplo efeitos a mais. farei o knockback de exemplo
			queue_free()

func apply_knockback_force(target):
	var knockback_direction = (target.global_position - global_position).normalized()
	target.position += knockback_direction * knockback_force * get_process_delta_time()

func apply_elemental_effect(target, element_type):
	var effect_data = create_elemental_effect(element_type)
	
	if effect_data:
		apply_status_effect(target, effect_data)
		apply_visual_effect(target, effect_data)
		

func create_elemental_effect(element_type):
	var effect = {}
	if element_type == "electric":
		effect = {
			"speed_reduction": 1,
			"damage_over_time": damage_over_time,
			"effect_duration": effect_duration,
			"visual_effect": electric_preload,
			"animation": "hurt_shoke"
		}
	elif element_type == "fire":
		effect = {
			"speed_reduction": 0,
			"damage_over_time": damage_over_time,
			"effect_duration": effect_duration,
			"visual_effect": fire_preload,
			"animation": "hurt_burn"
		}
	return effect

func apply_status_effect(target, effect_data):
	if target.has_method("apply_status"):
		target.apply_status(target,effect_data)

func apply_visual_effect(target, effect_data):
	var visual_instance = effect_data["visual_effect"].instantiate()
	visual_instance.lifetime = effect_data["effect_duration"]
	visual_instance.position = target.global_position
	visual_instance.one_shot = true
	get_parent().add_child(visual_instance)
	target.animation.play(effect_data["animation"])
