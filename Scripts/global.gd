extends Node
signal gold_changed(new_gold : int)

enum GameMode {TUTORIAL, NORMAL}
var game_mode := GameMode.TUTORIAL

var can_play_cards = false

var joy_warning_yesterday : bool = false
var anguish_warning_yesterday : bool = false

const JOY_WARNING = 20
const ANGUISH_WARNING = 20


var gold    : int = 100
var default_energy : int = 3
var energy  : int = default_energy
var joy     : float = 50
var anguish : float = 50
var day     : int = 1
var run_deck : Array[Card] = []
#Day variables
var plesed_customers        : int = 0
var secret_ingredients_added: int = 0
var killed_customers        : int = 0
var cards_used              : int = 0
var cards_remaining         : int = 0


func end_day_check():
	print_debug("End day check")
	var joy_bad = Global.joy < JOY_WARNING
	var anguish_bad = Global.anguish < ANGUISH_WARNING
	#JOY
	if joy_bad:
		if joy_warning_yesterday:
			#TODO: Function game_over()
			#game_over()
			print("Game over JOY")
		else:
			joy_warning_yesterday = true
	else:
		joy_warning_yesterday = false
	#ANGUISH
	if anguish_bad:
		if anguish_warning_yesterday:
			#game_over()
			print("Game Over ANGUISH")
		else:
			anguish_warning_yesterday = true
	else:
		anguish_warning_yesterday = false
		
	print("Joy")
	print(joy_bad)
	print(joy_warning_yesterday)
	print("anguish")
	print(anguish_bad)
	print(anguish_warning_yesterday)

func reset_run_deck(starting_deck : Array[Card]):
	run_deck = starting_deck.duplicate()

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
	joy = max(0, joy + value)
	
func add_anguish(value):
	anguish = max(0, anguish + value)

func add_energy(value):
	energy = max(0, energy + value)
	get_tree().call_group("energy_ui", "update_counter")
	
func add_gold(value):
	gold = max(0, gold + value)
	gold_changed.emit(gold)
	get_tree().call_group("gold_ui", "update_counter")
