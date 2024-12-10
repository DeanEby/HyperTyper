extends Node


var words = [
# General Themes
	"cowboy", "cowgirl", "ranch", "wrangler", "buckaroo", "gunslinger", "outlaw", 
	"trail", "frontier", "lasso", "cattle", "herd", "rodeo", "saddle", "spurs", 
	"rancher", "pioneer", "wild west", "homesteader", "cowpoke", "vaquero", 
	"trail boss", "settler", "bandit", "maverick", "sodbuster", "rustler", 
	"marshal", "deputy",

	# Locations and Landscapes
	"prairie", "desert", "canyon", "mesa", "plateau", "badlands", "range", 
	"homestead", "saloon", "gulch", "campfire", "trailhead", "valley", "outpost", 
	"watering hole", "mining town", "boomtown", "ghost town", "butte", "bluffs",

	# Objects and Gear
	"six-shooter", "revolver", "rifle", "holster", "chaps", "bandana", "boots", 
	"stetson", "bridle", "spurs", "stirrup", "wagon", "saddlebag", "canteen", 
	"branding iron", "horse blanket", "bullwhip", "lantern", "pickaxe", 
	"gold pan", "spur rowel", "tin star", "whetstone", "cowbell", 

	# Animals
	"mustang", "bronco", "longhorn", "steer", "bison",
	"jackrabbit", "armadillo", "coyote", "wolf", "eagle", "buzzard", "vulture", 
	"bobcat", "roadrunner", "quail",

	# Activities
	"herding", "branding", "roping", "rustling", "prospecting", "riding", 
	"wrangling", "gunfight", "stampede", "roundup", "trailblazing",
	 "duel", 

	# Iconic Phrases and Concepts
	"high noon", "wanted poster", "dust storm", "gold rush", "tumbleweed", 
	"campfire stories", "open range", "lawless", "saddle up", "posse", 
	"ride into the sunset", "rustler's moon", "riding shotgun", "shootout", 
	"no man's land", "land rush", "quick draw", "stagecoach", "train robbery", 
	"frontier justice", "claim jumper", "buffalo hunt", "hangman's noose", 
	"bar fight", "shootout at dawn", "on the range", "pay dirt", "snake oil", 
	"iron horse"
]

var special_characters = [
	".",
	"!",
	"?",
]


func get_prompt() -> String:
	var word_index = randi() % words.size()
	var special_index = randi() % special_characters.size()
	
	var word = words[word_index]
	var special_character = special_characters[special_index]
	
	var actual_word = word.substr(0, 1).to_upper() + word.substr(1)
	
	return actual_word + special_character
