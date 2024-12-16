extends PanelContainer
#@onready var 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var restart_button = %CenterContainer/VBoxContainer/RestartButton
	pass # Replace with function body.

func _on_restart_button_pressed() -> void:
	GlobalSignals.emit_signal("restart_game")
