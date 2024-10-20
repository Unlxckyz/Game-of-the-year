extends CharacterBody2D

@onready var sprite = $Rogues
var speed = 200
var lightning_bolt_preload = preload("res://spells/lightning_bolt.tscn")
var fireblast_preload = preload("res://spells/fire_blast.tscn")
var canShoot = true
@onready var timer = $Timer

var start_color: Color = Color8(231, 168, 40, 208)
var end_color: Color = Color8(175, 170, 251, 208)

var transition_speed: float = 0.7
var transition_progress: float = 0.0
var is_forward: bool = true

func _process(delta):
	handleMovement()
	handleCasting()

	if is_forward:
		transition_progress += delta * transition_speed
	else:
		transition_progress -= delta * transition_speed

	transition_progress = clamp(transition_progress, 0.0, 1.0)
	var current_color: Color = Color(lerp(start_color, end_color, transition_progress))
	modulate = current_color

	if transition_progress == 1.0:
		is_forward = false
	elif transition_progress == 0.0:
		is_forward = true

func shoot(projectile_scene):
	var projectile_instance = projectile_scene.instantiate()
	var direction = (get_global_mouse_position() - global_position).normalized()
	
	projectile_instance.position = global_position
	projectile_instance.direction = get_local_mouse_position()
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
			shoot(lightning_bolt_preload)
	if Input.is_action_pressed("shoot_fire"):
		if canShoot:
			shoot(fireblast_preload)

func _on_timer_timeout() -> void:
	canShoot = true
