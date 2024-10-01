extends Node2D
@onready var path = $Path2D/PathFollow2D
@onready var mob_preload = preload("res://scenes/characters/Enemies/spider.tscn")

func _physics_process(delta: float) -> void:
	spawn()
func spawn():
	var spider = mob_preload.instantiate()
	path.progress_ratio = randf()
	spider.position = path.position
	get_parent().add_child(spider)
