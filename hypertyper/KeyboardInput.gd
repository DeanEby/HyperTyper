extends Node

signal keyboard_input(key_typed)

var right_shift_characters = ["~", "!", "@", "#", "$", "%", "Q", "W", "E", "R", "T", "A", "S", "D", "F", "G", "Z", "X", "C", "V"]
var middle_shift_characters = ["B", "Y", "^"]
var left_shift_characters = ["&", "*", "(", ")", "_", "+", "U", "I", "O", "P", "{", "}", "|", "J", "K", "L", ":", "\"", "H", "N", "M", "<", ">", "?"]

var last_shift: String = ""



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event = event as InputEventKey
		#print("keycode:", typed_event.keycode)
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		# detecting which side of the keyboard the last shift occurred on
		if typed_event.as_text_keycode() == "Shift":
			last_shift = typed_event.as_text_location()
			print(last_shift)
		else:
			# detecting bad shifting but not sure what to do with it yet
			if key_typed in right_shift_characters && last_shift != "right":
				print("bad shifting")
			elif key_typed in left_shift_characters && last_shift != "left":
				print("bad shifting")
		# get the character that the user typed
			emit_signal("keyboard_input", key_typed)
		
		
		
