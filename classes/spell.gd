extends Node2D
class_name Spell

@export var spell_level: int
@export var speed: float    # Velocidade do feitiço
@export var direction: Vector2     # Direção do feitiço
@export var base_damage: int      # Dano base do feitiço
@export var range: float     # Alcance do feitiço
@export var mana_cost: int     # Custo de mana 
@export var cooldown_time: float  # Tempo de recarga 
@export var elemental_type: String
@export var effect_duration: float  # Duração dos efeitos do feitiço
@export var has_area_of_effect: bool # Se o feitiço possui área de efeito
@export var can_pierce: bool    # Se o feitiço pode atravessar inimigos
@export var knockback_force: float  # Força de empurrão aplicada aos inimigos atingidos
@export var damage_over_time: int  # Dano por segundo durante a duração do efeito
@export var heal_amount: int    # Quantidade de vida recuperada se o feitiço for curativo
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
		apply_damage_over_time(target, effect_data)

func create_elemental_effect(element_type):
	var effect = {}
	if element_type == "electric":
		effect = {
			"speed_reduction": 0,
			"damage_over_time": 0,
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
	if effect_data.has("speed_reduction"):
		target.speed -= effect_data["speed_reduction"]
	if target.has_method("apply_status"):
		target.apply_status(effect_data)

func apply_visual_effect(target, effect_data):
	var visual_instance = effect_data["visual_effect"].instantiate()
	visual_instance.lifetime = effect_data["effect_duration"]
	visual_instance.position = target.global_position
	visual_instance.one_shot = true
	get_parent().add_child(visual_instance)
	
	target.animation.play(effect_data["animation"])

func apply_damage_over_time(target, effect_data):
	if effect_data.has("damage_over_time"):
		target.timer.wait_time = effect_data["effect_duration"]
		
		if target.currentHealth > 0:
			target.take_damage(effect_data["damage_over_time"])
