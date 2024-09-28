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
				apply_elemental(body,elemental_type)
			
				
			#aqui é adicionado por exemplo efeitos a mais. farei o knockback de exemplo
			
			queue_free()

func apply_knockback_force(body):
	var knockback_direction = (body.global_position - global_position).normalized()
	body.position += knockback_direction * knockback_force * get_process_delta_time()

func apply_elemental(body,elemental):
	var electric_effect = electric_preload.instantiate()
	var fire_effect = fire_preload.instantiate()
	if elemental == "electric":
		body.speed = 0
		body.timer.wait_time = effect_duration
		if body.currentHealth > 0:
			electric_effect.lifetime = effect_duration
			body.animation.play("hurt_shoke")
			electric_effect.position = body.global_position
			electric_effect.one_shot = true
			get_parent().add_child(electric_effect)
			
		body.shoke()
	if elemental == "fire":
		
		#var tickTimer = Timer.new()
		#tickTimer.wait_time = 1.0
		#tickTimer.one_shot = false
		#tickTimer.start()
		if body.currentHealth > 0:
			fire_effect.damageOverTime(body,damage_over_time,effect_duration)
			fire_effect.lifetime = effect_duration
			body.animation.play("hurt_shoke")
			fire_effect.position = body.global_position
			print(body.currentHealth)
			get_parent().add_child(fire_effect)
