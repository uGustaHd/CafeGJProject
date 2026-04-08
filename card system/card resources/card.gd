@tool
extends Resource
class_name Card


#region properties
@export var title : String
@export var card_art : Texture
@export var archetype : Archetype
enum Archetype {RED, GREEN, BLUE, GOLD, PURPLE, RAINBOW}
@export var shop_price : int = 10
@export_multiline var effect_text : String
# Not seen in game, just for leaving notes on design intentions
@export_multiline var designer_notes : String

@export_storage var effects : Array[CardEffect]
@export_storage var costs : Array[CardCost]

@export var energy_add : int = 0
@export var draw_add : int = 0
@export var kill_add : float = 0
@export var gold_add : int = 0

@export var red_add : int = 0
@export var green_add : int = 0
@export var blue_add : int = 0

@export var joy_add : int = 0
@export var anguish_add : int = 0

@export var green_multiply : int = 1
@export var blue_multiply : int = 1
@export var red_multiply : int = 1

@export var energy_cost : int = 1
@export var joy_cost : int = 0
@export var anguish_cost : int = 0
@export var kill_cost : int = 0 # Restricted to ints to avoid displaying floats on cost icons.

@export var red_multiplier_cost : int = 0
@export var green_multiplier_cost : int = 0
@export var blue_multiplier_cost : int = 0

@export var red_cost : int = 0
@export var green_cost : int = 0
@export var blue_cost : int = 0

# TODO: Remove evil var and references to it.
# Mainly for counting "secret ingredients" in end of day report.
@export var evil : bool = false

#endregion

#region Effect Spawning
func clear_effects_and_costs():
	effects.clear()
	costs.clear()

func add_effect_resources():
	if energy_add > 0:
		effects.append(load("res://card system/effect resources/effects/AddEnergy.tres"))
	print_debug("Card resource readied, energy add = ", energy_add)

func add_cost_resources():
	pass

#endregion

#region Cost Spawning

#endregion
