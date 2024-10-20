extends CanvasModulate

var start_color: Color = Color8(231, 168, 40, 208)
var end_color: Color = Color8(175, 170, 251, 208)

var transition_speed: float = 0.7
var transition_progress: float = 0.0
var is_forward: bool = true

func _process(delta: float) -> void:
	if is_forward:
		transition_progress += delta * transition_speed
	else:
		transition_progress -= delta * transition_speed

	transition_progress = clamp(transition_progress, 0.0, 1.0)

	var current_color: Color = Color(lerp(start_color, end_color, transition_progress))

	color = current_color

	if transition_progress == 1.0:
		is_forward = false
	elif transition_progress == 0.0:
		is_forward = true
