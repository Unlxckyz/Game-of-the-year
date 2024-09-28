
extends Enemy
@onready var animation = $AnimationPlayer
@onready var health_bar_bar = $HealthComponent
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var timer = $Effect

func _init():
	health = 5000
	health_bar = health_bar_bar
	speed = 50
	
	


func _process(delta):
	var direction = (player.global_position - global_position).normalized()
	position += direction * speed * delta
	
func shoke():
	animation.play("hurt_shoke")
	timer.start()

func _on_effect_timeout() -> void:
	speed = 50
