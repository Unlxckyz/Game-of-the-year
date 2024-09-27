extends Node2D
var speed = 300
var damage = 10
var direction = Vector2.ZERO
func _process(delta):
	
	position += direction.normalized() * delta * speed


func _on_eletric_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
