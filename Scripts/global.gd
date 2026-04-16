extends Node
signal gold_changed(new_gold : int)

enum GameMode {TUTORIAL, NORMAL}
var game_mode := GameMode.NORMAL

var can_play_cards = false

var joy_warning_yesterday : bool = false
var anguish_warning_yesterday : bool = false

const JOY_WARNING = 20
const ANGUISH_WARNING = 20
enum GameOver {DAY, JOY, ANGUISH}
var game_over_reason : GameOver
var game_over_scene: PackedScene = preload("res://game_over.tscn")

var gold    : int = 0
var default_energy : int = 3
var energy  : int = default_energy
var joy     : float = 50
var anguish : float = 50
var kill : float = 0
var day     : int = 1
var run_deck : Array[Card] = []
#Day variables
var plesed_customers        : int = 0
var killed_customers        : int = 0
var secret_ingredients_added: int = 0
var cards_used              : int = 0
var cards_remaining         : int = 0

var fatigue : int = 0

func end_day_check():
	print_debug("End day check")
	var joy_bad = Global.joy < JOY_WARNING
	var anguish_bad = Global.anguish < ANGUISH_WARNING
	#JOY
	if joy_bad:
		if joy_warning_yesterday:
			game_over_reason = GameOver.JOY
			get_tree().change_scene_to_file("res://game_over.tscn")
		else:
			joy_warning_yesterday = true
	else:
		joy_warning_yesterday = false
	#ANGUISH
	if anguish_bad:
		if anguish_warning_yesterday:
			game_over_reason = GameOver.JOY
			get_tree().change_scene_to_file("res://game_over.tscn")
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

func reset() -> void:
	joy_warning_yesterday = false
	anguish_warning_yesterday = false
	gold = 0
	joy = 50
	anguish = 50
	kill = 0
	day = 1
	plesed_customers = 0
	killed_customers = 0
	secret_ingredients_added = 0
	cards_used = 0
	cards_remaining = 0
	reset_fatigue()

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
	get_tree().call_group("joy_ui", "update")
	
func add_anguish(value):
	anguish = max(0, anguish + value)
	get_tree().call_group("anguish_ui", "update")

func add_energy(value):
	energy = max(0, energy + value)
	get_tree().call_group("energy_ui", "update_counter")
	
func add_gold(value):
	gold = max(0, gold + value)
	gold_changed.emit(gold)
	get_tree().call_group("gold_ui", "update_counter")
	
func add_kill(value):
	kill = max(0, kill + value)
	get_tree().call_group("kill_ui", "update_meter")
	
# NOTE: Updating fatigue on cards is handled by cards when cards are played only. 
func add_fatigue(value):
	fatigue = max(0, fatigue + value)
	
func reset_fatigue():
	fatigue = 0
	
#region debug
func _process(_delta: float) -> void:
	if OS.is_debug_build():
		if Input.is_action_just_pressed("add_kill"):
			add_kill(1)
			
		if Input.is_action_just_pressed("add_energy"):
			add_energy(1) 
#endregion
