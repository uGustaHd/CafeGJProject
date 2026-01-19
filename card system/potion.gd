extends Resource
class_name Potion
# Stores values of potion


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
