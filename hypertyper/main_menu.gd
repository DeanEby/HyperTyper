extends Control



func _on_test_scene_select_pressed() -> void:
	GlobalSignals.emit_signal("scene_select", "TestScene")


func _on_high_noon_select_pressed() -> void:
	GlobalSignals.emit_signal("scene_select", "HighNoon")


func _on_options_select_pressed() -> void:
	pass # Replace with function body.
