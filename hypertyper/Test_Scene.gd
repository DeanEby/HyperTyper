extends Node2D

var Enemy = preload("res://Enemy.tscn")

@onready var enemy_container = $EnemyContainer

@onready var spawn_container = $SpawnContainer

@onready var spawn_timer = $SpawnTimer

@onready var difficulty_timer = $DifficultyTimer

@onready var difficulty_value = $CanvasLayer/VBoxContainer/BottomRow/HBoxContainer/DifficultyValue
@onready var killed_value = $CanvasLayer/VBoxContainer/TopRow/TopRow2/EnemiesKilledValue

var active_enemy = null

# for the active enemy, which character are we on
var current_letter_index: int = -1

var difficulty: int = 0

var enemies_killed: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	KeyboardInput.keyboard_input.connect(handle_key_input)
	start_stage()
	pass

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func strip_BB_code_tags(text: String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	var output = regex.sub(text, "", true)
	return output

func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		prompt = strip_BB_code_tags(prompt)
		var next_character = prompt.substr(0,1)
		
		# is the first char of prompt the char typed?
		if next_character == typed_character:
			active_enemy = enemy
			print("found new enemy that starts with %s" % next_character)
			current_letter_index = 1
			active_enemy.set_next_character(current_letter_index)
			return


func handle_key_input(key_typed):
		if active_enemy == null:
			find_new_active_enemy(key_typed)
		else:
			var prompt = active_enemy.get_prompt()
			prompt = strip_BB_code_tags(prompt)
			var next_character = prompt.substr(current_letter_index, 1)
			
			if key_typed == next_character:
				print("successfully typed %s" % key_typed)
				current_letter_index +=1
				active_enemy.set_next_character(current_letter_index)
				
				if current_letter_index == prompt.length():
					print("done")
					current_letter_index = -1
					active_enemy.queue_free()
					active_enemy = null
					enemies_killed += 1
					killed_value.text = str(enemies_killed)
			else:
				print("incorrectly typed %s instead of %s" % [key_typed, next_character])
			
			
		 


func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
	
func spawn_enemy():
	var enemy_instance = Enemy.instantiate()
	var spawns = spawn_container.get_children()
	var index = randi() % spawns.size()
	enemy_instance.global_position = spawns[index].global_position
	enemy_container.add_child(enemy_instance)
	enemy_instance.set_difficulty(difficulty)

func _on_difficulty_timer_timeout() -> void:
	difficulty += 1
	GlobalSignals.emit_signal("difficulty_increased", difficulty)
	print("difficulty increased to %d" % difficulty)
	var new_wait_time = spawn_timer.wait_time - 0.125
	spawn_timer.wait_time = clamp(new_wait_time, 1, spawn_timer.wait_time)
	difficulty_value.text = str(difficulty)


func _on_lose_area_body_entered(body: Node2D) -> void:
	round_over()
	GlobalSignals.emit_signal("stage_round_over")
	
	
func round_over():
	
	spawn_timer.stop()
	difficulty_timer.stop()
	active_enemy = null
	current_letter_index = -1
	#clear out stuff
	for enemy in enemy_container.get_children():
		enemy.queue_free()
	
	
func start_stage():
	print("stage started" + self.name)
	difficulty = 0
	enemies_killed = 0
	difficulty_value.text = "0"
	killed_value.text = "0"
	randomize()
	spawn_timer.start()
	difficulty_timer.start()
	spawn_enemy()
	



	
