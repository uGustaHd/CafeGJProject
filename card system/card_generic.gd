extends Control


var card_resource : Card

@onready var effect_text : RichTextLabel = $Base/EffectText
@onready var title : RichTextLabel = $Art/Title
@onready var energy_cost : RichTextLabel = $CostIcon/EnergyCost
@onready var art : TextureRect = $Art



# Called by HandHolder once card resource is added.
func initialize_card(source_card : Card) -> void:
	card_resource = source_card
	art.texture = card_resource.card_art
	title.text = card_resource.title
	energy_cost.text = str(card_resource.energy_cost)
	effect_text.text = card_resource.effect_text
	fill_additional_costs()

#TODO: If card has costs other that energy, should add those icons to card.
func fill_additional_costs() -> void:
	pass
