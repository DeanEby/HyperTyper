extends PanelContainer
@onready var restart_button = %CenterContainer/VBoxContainer/RestartButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_restart_button_pressed() -> void:
	GlobalSignals.emit_signal("restart_game")
