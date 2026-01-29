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

var status : Status = Status.SHIFTING
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

func shift() -> void:
	# Get non-zero color indexes
	var i = 0
	var valid_giving_indexes : Array[int]
	var valid_taking_indexes : Array[int]
	for color in colors:
		valid_taking_indexes.append(i)
		if color >= 1:
			valid_giving_indexes.append(i)
		i += 1
		
	
	# Decide if shifting
	var chance_to_shift : int = 100
	var roll = randi_range(1,100)
	if chance_to_shift >= roll and valid_giving_indexes.size() > 0:
		
		print_debug("Potion shifting")
		var color_giving = valid_giving_indexes.pick_random()
		valid_taking_indexes.erase(color_giving)
		var color_taking = valid_taking_indexes.pick_random()
		if color_taking == color_giving:
			color_giving += 1
			if color_giving >= 2:
				color_giving = 0

		colors[color_taking] += 1
		colors[color_giving] -= 1
		print_debug("Potion BGR = ", colors)

func on_card_played():
	if status == Status.SHIFTING:
		shift()

#endregion
