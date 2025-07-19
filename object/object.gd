extends Node2D

signal destroyed

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("MOUSE_BUTTON_LEFT"):
		queue_free()
		
func _on_tree_exited() -> void:
	emit_signal("destroyed")
