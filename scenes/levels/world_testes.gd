extends Node2D
@onready var path = $Path2D/PathFollow2D
@onready var mob_preload = preload("res://scenes/characters/Enemies/spider.tscn")


func spawn():
	var spider = mob_preload.instantiate()
	path.progress_ratio = randf()
	spider.position = path.position
	get_parent().add_child(spider)
	spider.animation.stop()


func _on_timer_spawn_timeout() -> void:
	spawn()
