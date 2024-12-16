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
	GlobalSignals.scene_select.connect(load_stage)
	start_game()

	
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


func start_game():
	var main_menu = ui[0]
	main_menu = main_menu.instantiate()
	main_ui.add_child(main_menu)
	#load_stage()
	pass

	# will probably want to move this out of main soon
func load_stage(stage):
	var new_stage
	if stage == "HighNoon":
		new_stage = stages[1]
	if stage == "TestScene":
		new_stage = stages[0]
	else:
		print("woops stage name is not valid")
	# [0] for now need to change later
	new_stage = new_stage.instantiate()
	# needed so we can remove scenes without removing other main children
	stage_loader.add_child(new_stage)
	for child in main_ui.get_children():
		child.queue_free()
	
	
func handle_round_over():
	
	for scene in stage_loader.get_children():
		scene.queue_free()
	var game_over_screen = ui[1]
	game_over_screen = game_over_screen.instantiate()
	main_ui.add_child(game_over_screen)
	
