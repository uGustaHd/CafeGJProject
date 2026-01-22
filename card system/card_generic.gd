extends Control

#WARNING: Only an export for testing
@export var card_resource : Card
var art : Texture
var card_text : String
var costs : Dictionary[String, int] = {
"Energy" : 0,
"Joy" : 0,
"Anguish" : 0,
"Green" : 0,
"Blue" : 0,
"Red" : 0,
}

# Called by HandHolder once card resource is added.
func initialize_card(source_card : Card) -> void:
	card_resource = source_card
	art = card_resource.card_art
	costs["Energy"] = card_resource.energy_cost
	costs["Joy"] = card_resource.joy_cost
	costs["Anguish"] = card_resource.anguish_cost
	costs["Green"] = card_resource.green_cost
	costs["Blue"] = card_resource.blue_cost
	costs["Red"] = card_resource.red_cost
