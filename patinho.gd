
extends Enemy
@onready var animation = $AnimationPlayer
@onready var health_component = $HealthComponent
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label = $Label

func _init():
	maxHealth = 100
	
	health_bar = health_component
	speed = 50
	
	

func _process(delta):
	var direction = (player.global_position - global_position).normalized()
	position += direction * speed * delta
	if speed == 0:
		label.visible = true
	else:
		label.visible = false
		
	
func shoke():
	animation.play("hurt_shoke")


func _on_health_component_value_changed(value: float) -> void:
	pass # Replace with function body.
