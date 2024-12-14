extends Node2D

@onready var stage_loader = %StageLoader

@onready var main_ui = %MainUI

@export var ui:Array[PackedScene] = []
#Add scenes in inspector
@export var stages:Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.stage_round_over.connect(handle_round_over)
	GlobalSignals.restart_game.connect(restart_game)
	start_game()
	
	pass
	
func restart_game():
	for child in main_ui.get_children():
		child.queue_free()
	start_game()

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey and event.is_pressed():
		#var typed_event = event as InputEventKey
		##print("keycode:", typed_event.keycode)
		#var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
#
		#if typed_event.as_text_keycode() == "Shift":
			#
			#print("shift")
			#
		#else:
			#pass
		## get the character that the user typed
			##GlobalSignals.emit_signal("keyboard_input", key_typed)
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_game():
	load_stage()
	pass

	# will probably want to move this out of main soon
func load_stage():
	# [0] for now need to change later
	#print(scenes[0])
	var new_stage = stages[0]
	new_stage = new_stage.instantiate()
	# needed so we can remove scenes without removing other main children
	stage_loader.add_child(new_stage)
	
func handle_round_over():
	
	for scene in stage_loader.get_children():
		scene.queue_free()
	var game_over_screen = ui[0]
	game_over_screen = game_over_screen.instantiate()
	main_ui.add_child(game_over_screen)
	
