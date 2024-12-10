extends Node2D

@export var scenes:Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_game():
	load_stage()
	pass


func load_stage():
	# [0] for now need to change later
	var new_scene = scenes[0]
	new_scene = new_scene.instantiate()
	add_child(new_scene)
	
	
