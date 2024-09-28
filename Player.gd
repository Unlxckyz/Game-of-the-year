extends CharacterBody2D

@onready var sprite = $Rogues
var speed = 200
var lightning_bolt_preload = preload("res://spells/lightning_bolt.tscn")
var fireblast_preload = preload("res://spells/fire_blast.tscn")
var canShoot = true
@onready var timer = $Timer

func _process(delta):
	handleMovement()
	handleCasting()
	

func shoot(projectile_scene, target_position):
	var projectile_instance = projectile_scene.instantiate()
	var direction = (target_position - global_position).normalized()
	
	projectile_instance.position = global_position
	projectile_instance.direction = target_position
	projectile_instance.rotation = direction.angle()
	
	var animation_player = projectile_instance.get_node("animation")
	animation_player.play("shoot")
	
	get_parent().add_child(projectile_instance)
	canShoot = false
	timer.start()

func handleMovement():
	var direction = Input.get_vector("left","right","up","down")
	if direction.x > 0:
		sprite.flip_h = true
	if direction.x < 0:
		sprite.flip_h = false
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func handleCasting():
	if Input.is_action_pressed("shoot"):
		if canShoot:
			shoot(lightning_bolt_preload, get_global_mouse_position())
	if Input.is_action_pressed("shoot_fire"):
		if canShoot:
			shoot(fireblast_preload, get_global_mouse_position())

func _on_timer_timeout() -> void:
	canShoot = true
