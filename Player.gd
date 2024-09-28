extends CharacterBody2D
@onready var sprite = $Rogues
var speed = 200
var eletricidade_preload = preload("res://spells/lightning_bolt.tscn")
var fireblast_preload = preload("res://spells/fire_blast.tscn")
var canShoot = true
@onready var timer = $Timer
func _process(delta):
	var direction = Input.get_vector("left","right","up","down")
	if direction.x > 0:
		sprite.flip_h = true
	if direction.x < 0:
		sprite.flip_h = false
		
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	if Input.is_action_pressed("shoot"):
		if canShoot:
			shoot(eletricidade_preload)
	if Input.is_action_pressed("shoot_fire"):
		if canShoot:
			shoot(fireblast_preload)
		
		
		

func shoot(spell):
	var eletricidade
	if spell == fireblast_preload:
		eletricidade = fireblast_preload.instantiate()
	if spell == eletricidade_preload:
		eletricidade = eletricidade_preload.instantiate()
	var angle = (get_global_mouse_position() - global_position).normalized()
	var animation = eletricidade.get_node("animation")
	animation.play("shoot")
	eletricidade.position = global_position
	eletricidade.direction = get_local_mouse_position()
	eletricidade.rotation = angle.angle()
	
	get_parent().add_child(eletricidade)
	canShoot = false
	timer.start()
	
	


func _on_timer_timeout() -> void:
	canShoot = true
