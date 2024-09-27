extends Node2D
class_name Spell

@export var spell_level: int
@export var speed: float    # Velocidade do feitiço
@export var direction: Vector2     # Direção do feitiço
@export var base_damage: int      # Dano base do feitiço
@export var range: float     # Alcance do feitiço
@export var mana_cost: int     # Custo de mana 
@export var cooldown_time: float  # Tempo de recarga 
@export var elemental_type: Dictionary = {}
@export var effect_duration: float  # Duração dos efeitos do feitiço
@export var has_area_of_effect: bool # Se o feitiço possui área de efeito
@export var can_pierce: bool    # Se o feitiço pode atravessar inimigos
@export var knockback_force: float  # Força de empurrão aplicada aos inimigos atingidos
@export var damage_over_time: int  # Dano por segundo durante a duração do efeito
@export var heal_amount: int    # Quantidade de vida recuperada se o feitiço for curativo

func _process(delta: float) -> void:
	position += direction.normalized() * delta * speed
