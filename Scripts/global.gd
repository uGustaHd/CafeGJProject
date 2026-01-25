extends Node

var gold    : int = 0
var default_energy : int = 3
var energy  : int = default_energy
var joy     : float = 0
var anguish : float = 0
var day     : int = 1

#Day variables
var plesed_customers        : int = 0
var secret_ingredients_added: int = 0
var killed_customers        : int = 0
var cards_used              : int = 0
var cards_remaining         : int = 0

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
#NOTE: Doesn't this double the joy and then add the value bc of +=? idk I didnt test yet.
func add_joy(value):
	joy += max(0, joy + value)
	
func add_anguish(value):
	anguish += max(0, anguish + value)

func add_energy(value):
	energy = max(0, energy + value)
	
func add_gold(value):
	gold = max(0, gold + value)
	get_tree().call_group("gold_ui", "update_counter")
