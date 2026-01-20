extends Resource
class_name Potion
# Stores values of potion


enum potion_type {TALL, WIDE}

#region properties
@export var blue : int = 0:
	set(value):
		blue += value * blue_multiplier
		
@export var green : int = 0:
	set(value):
		green += value * green_multiplier

@export var red : int = 0:
	set(value):
		red += value * red_multiplier

var colors : Array[int] = [blue, green, red]

#endregion

#region multipliers
var red_multiplier : int = 1
var blue_multiplier : int = 1
var green_multiplier : int = 1

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
					
	print_debug("Potion bgr = ", colors)
	return self

#endregion
