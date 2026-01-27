extends Resource
class_name Potion
# Stores values of potion


enum potion_type {TALL, WIDE}

#region properties
@export var blue : int = 0
@export var green : int = 0
@export var red : int = 0
var colors : Array[int] = [blue, green, red]

var red_multiplier : int = 1
var blue_multiplier : int = 1
var green_multiplier : int = 1

var status : Status
enum Status {SHIFTING, VOLATILE}

# Used for comparisons
var requested_potion : Potion

#endregion

#_______________________________________________________________________________
#region setters
func add_blue(value: int):
	blue += value * blue_multiplier
	colors[0] = blue
	
func add_green(value: int):
	green += value * green_multiplier
	colors[1] = green
	
func add_red(value: int):
	red += value * red_multiplier
	colors[2] = red

func reset_potion():
	red = 0
	blue = 0
	green = 0 
	colors = [0,0,0]

#endregion

#region logic
#NOTE: This generation is very simplistic, and can be improved later.
func generate_potion(difficulty : int) -> Potion:
	var type : potion_type = randi() % potion_type.size() as potion_type
	
	match type:
		potion_type.TALL:
			print_debug("Tall potion generated")
			var tall_color_index = randi() % colors.size()
			colors[tall_color_index] = 2 + difficulty
			for i in colors.size():
				if i != tall_color_index:
					colors[i] += difficulty
		
		potion_type.WIDE:
			print_debug("Wide potion generated")
			var total_color_add = difficulty + 3
			# Randomizes starting index
			var i = randi() % colors.size()
			while total_color_add > 0:
				colors[i] += 1
				total_color_add -= 1
				i += 1
				if i > colors.size() - 1:
					i = 0
	blue = colors[0]
	green = colors[1]
	red = colors[2]
	print_debug("Potion bgr = ", colors)
	return self

func on_card_played():
		if status == Status.SHIFTING:
			pass

#endregion
