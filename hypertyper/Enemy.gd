extends CharacterBody2D

# typing colors under enemy
# prev typed: grey, current: blue, to type: white
@export var grey = Color("#818181")
@export var blue = Color("#22c995")
@export var white = Color("#ffffff")

@export var speed = 1





@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# I dont love this parse_bbcode call
	#prompt.parse_bbcode("[center]" + prompt_text + "[/center]")
	prompt_text = TestPrompts.get_prompt()
	prompt.parse_bbcode(set_center_tags(prompt_text))
	#GlobalSignals.connect("difficulty_increased", self, "handle_difficulty_increased")
	GlobalSignals.difficulty_increased.connect(handle_difficulty_increased)



func _physics_process(delta: float) -> void:
	global_position.x -= speed
	
	
func set_difficulty(difficulty: int):
	handle_difficulty_increased(difficulty)
	
func handle_difficulty_increased(new_difficulty: int):
	var new_speed = speed + (0.2 * new_difficulty)
	speed = clamp(new_speed, speed, 3)

func get_prompt() -> String:
	return prompt_text
	
	
func set_next_character(next_character_index: int):
	# lots of strings here, may need to be optimized
	var grey_text = get_bbcode_color_tag(grey) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	
	var white_text = ""
	if next_character_index != prompt_text.length():
		white_text = get_bbcode_color_tag(white) + prompt_text.substr(next_character_index + 1, prompt_text.length() - next_character_index + 1) + get_bbcode_end_color_tag()
	prompt.parse_bbcode(set_center_tags(grey_text + blue_text + white_text))
	
	
	
func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"
	

func get_bbcode_end_color_tag() -> String:
	return "[/color]"

func set_center_tags(string_to_center: String):
	# inefficient
	return "[center]" + string_to_center + "[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
