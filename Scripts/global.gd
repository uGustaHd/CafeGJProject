extends Node

var gold    : int = 1
var joy     : float = 0
var anguish : float = 0
var day     : int = 1

#Day variables
var plesed_customers        : int = 2
var secret_ingredients_added: int = 3
var killed_customers        : int = 4
var cards_used              : int = 5
var cards_remaining         : int = 6

func day_variables_to_zero():
	plesed_customers = 0
	secret_ingredients_added = 0
	killed_customers = 0
	cards_used = 0
	cards_remaining = 0

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
