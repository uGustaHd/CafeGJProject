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

var status : Status = Status.NORMAL
#NOTE: Volatile will not be used for jam build
enum Status {NORMAL, SHIFTING, VOLATILE}

# Used for comparisons
var requested_potion : Potion

#endregion

#_______________________________________________________________________________
#region setters
func add_red(value: int):
	if red_multiplier >= 0:
		red += value * red_multiplier
		colors[2] = red
	
	elif red_multiplier < 0:
		@warning_ignore("narrowing_conversion")
		red += ceilf(float(value) / float(-red_multiplier))
		colors[2] = red

func add_green(value: int):
	if green_multiplier >= 0:
		green += value * green_multiplier
		colors[2] = green
	
	elif green_multiplier < 0:
		@warning_ignore("narrowing_conversion")
		green += ceilf(float(value) / float(-green_multiplier))
		colors[2] = green

func add_blue(value: int):
	if blue_multiplier >= 0:
		blue += value * blue_multiplier
		colors[2] = blue
	
	elif blue_multiplier < 0:
		@warning_ignore("narrowing_conversion")
		blue += ceilf(float(value) / float(-blue_multiplier))
		colors[2] = blue

# Used for adding multiplier instead of multiplying
func add_red_multiplier(value: int):
	if value != 0:
		# Skip over 0
		# Negative to positive:
		if red_multiplier < 0 and (red_multiplier + value) >= 0:
			value += 1
		
		# Positive to negative:
		if red_multiplier > 0 and (red_multiplier + value ) <= 0:
			value -= 1

		red_multiplier += value

func add_green_multiplier(value: int):
	if value != 0:
		# Skip over 0
		# Negative to positive:
		if green_multiplier < 0 and (green_multiplier + value) >= 0:
			value += 1
		
		# Positive to negative:
		if green_multiplier > 0 and (green_multiplier + value ) <= 0:
			value -= 1

		green_multiplier += value
	
func add_blue_multiplier(value: int):
	if value != 0:
		# Skip over 0
		# Negative to positive:
		if blue_multiplier < 0 and (blue_multiplier + value) >= 0:
			value += 1
		
		# Positive to negative:
		if blue_multiplier > 0 and (blue_multiplier + value ) <= 0:
			value -= 1

		blue_multiplier += value

# Costs are same as add, but without multipliers
func cost_blue(value: int):
	blue += value
	colors[0] = blue
	
func cost_green(value: int):
	green += value
	colors[1] = green
	
func cost_red(value: int):
	red += value
	colors[2] = red

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

		colors[color_taking] += 1
		colors[color_giving] -= 1
		print_debug("Potion BGR = ", colors)

func on_card_played():
	if status == Status.SHIFTING:
		shift()

#endregion
