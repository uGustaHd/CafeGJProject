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

@export var flip_red_multiply : bool = false
@export var flip_green_multiply : bool = false
@export var flip_blue_multiply : bool = false

@export var energy_cost : int = 100 # Set arbitrarily high so that changing it indicates energy_cost is desired
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

# NOTE: This func isn't great but it is only run in editor infrequently so it's fine
# NOTE: Any new effects or costs will need to be manually referrenced here.
# WARNING: Most effects and costs support negative numbers, use != instead of >< for most cases.
func add_effect_resources():
# Effects
	# Multipliers should be added first for design reasons.
	if red_multiply != 1 or green_multiply != 1 or blue_multiply != 1:
		effects.append(load("res://card system/effect resources/effects/AddMultiplier.tres"))
	if energy_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddEnergy.tres"))
	if draw_add > 0: 
		effects.append(load("res://card system/effect resources/effects/AddDraw.tres"))
	if kill_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddKill.tres"))
	if gold_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddGold.tres"))
	if red_add != 0 or green_add != 0 or blue_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddColor.tres"))
	if joy_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddJoy.tres"))
	if anguish_add != 0:
		effects.append(load("res://card system/effect resources/effects/AddAnguish.tres"))
	# Multiplier flipping should be last for design reasons.
	if flip_red_multiply or flip_green_multiply or flip_blue_multiply:
		effects.append(load("res://card system/effect resources/effects/FlipMultiplier.tres"))

# Costs
	if energy_cost != 100:
		costs.append(load("res://card system/effect resources/costs/CostEnergy.tres"))
	if joy_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostJoy.tres"))
	if anguish_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostAnguish.tres"))
	if kill_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostKill.tres"))
	if red_multiplier_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostRedMultiplier.tres"))
	if blue_multiplier_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostBlueMultiplier.tres"))
	if green_multiplier_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostGreenMultiplier.tres"))
	if red_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostRed.tres"))
	if green_cost != 0: 
		costs.append(load("res://card system/effect resources/costs/CostGreen.tres"))
	if blue_cost != 0:
		costs.append(load("res://card system/effect resources/costs/CostBlue.tres"))

func add_cost_resources():
	pass

#endregion

#region Cost Spawning

#endregion
