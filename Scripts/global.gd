extends Node

var gold    : int = 0 
var joy     : float = 0
var anguish : float = 0
var day     : int = 1

func get_difficulty() -> int:
#NOTE: I think the game will have only 7 days
	match day:
		1, 2:
			return 1
		3, 4:
			return 2
		5, 6:
			return 3
		7:
			return 4
		_:
			return 4
func add_joy(value):
	joy += max(0, joy + value)
	
func add_anguish(value):
	anguish += max(0, anguish + value)
