extends Control

signal card_color_added(color_potion : Potion)
signal card_multiplier_added(multiplier_potion : Potion)
#region data
var card_resource : Card

@onready var DiscardPile : Pile = $"../../../../DiscardHolder".held_pile
@onready var HandPile : Pile = $"../../..".held_pile
@onready var PotionHolder = $"../../../../PotionHolder"
@onready var Dealer : Node = $"../../../../DeckHolder/Dealer"
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var button : Button = $Visuals/Button

@onready var effect_text : RichTextLabel = $Visuals/Base/EffectText
@onready var title : RichTextLabel = $Visuals/Art/Title
@onready var energy_cost : RichTextLabel = $Visuals/CostIcon/EnergyCost
@onready var art : TextureRect = $Visuals/Art

#endregion

#region fill card
# Called by HandHolder once card resource is added.
func initialize_card(source_card : Card) -> void:
	card_resource = source_card
	# Should remove any empty cards that get through.
	if card_resource == load("res://card system/card resources/is_empty.tres"):
		HandPile.take_card(card_resource)
		queue_free()
	art.texture = card_resource.card_art
	color_title()
	if card_resource.archetype != card_resource.Archetype.RAINBOW:
		title.add_text(card_resource.title) 
	energy_cost.text = str(card_resource.energy_cost)
	fill_effect_text()
	effect_text.add_text(card_resource.effect_text)
	fill_additional_costs()

#TODO: If card has costs other that energy, should add those icons to card.
func fill_additional_costs() -> void:
	pass
	
func fill_effect_text() -> void:
	var numericals = [card_resource.green_add, card_resource.blue_add, card_resource.red_add, card_resource.energy_add, card_resource.draw_add]
	# [green_add, blue_add, red_add, energy_add, draw_add]
	var numerical_strings : Array[String] = [
		" Green \n",
		" Blue \n",
		" Red \n",
		" Energy \n",
		" Draw \n",
	]
	var i = 0
	for value in numericals:
		if value != 0:
			var text_to_add : String = numerical_strings[i]
			if value > 0:
				text_to_add = "+" + str(value) + text_to_add
			elif value < 0:
				text_to_add = "-" + str(value) + text_to_add
			effect_text.add_text(text_to_add)
		i += 1
	
	# Write out multipliers
	var multipliers : Array[int] = [card_resource.green_multiply, card_resource.blue_multiply, card_resource.red_multiply]
	var multiplier_strings : Array[String] = [
		" Green",
		" Blue",
		" Red",
	]
	i = 0
	for value in multipliers:
		if value != 1:
			var text_to_add : String = multiplier_strings[i]
			text_to_add = "x" + str(value) + text_to_add
			effect_text.add_text(text_to_add)
		i += 1

# Assigns title directly if Rainbow
func color_title() -> void:
	match card_resource.archetype:
		card_resource.Archetype.RED:
			title.push_color(Color.RED)
		card_resource.Archetype.BLUE:
			title.push_color(Color.DODGER_BLUE)
		card_resource.Archetype.GREEN:
			title.push_color(Color.LIME_GREEN)
		card_resource.Archetype.RAINBOW:
			#[rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]{text}[/rainbow]
			title.text = "[rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]" + card_resource.title + "[/rainbow]"

#endregion

#region actions
func attempt_activation() -> bool:
	if card_resource.energy_cost <= Global.energy:
		activate()
		return true
	else:
		return false

func activate() -> void:
	add_color()
	add_multiplier()
	add_energy()
	add_draw()
	
	discard_self()
	pay_cost()

func add_draw():
	Dealer.deal_cards(card_resource.draw_add)
	
func add_energy():
	Global.add_energy(card_resource.energy_add)

func add_multiplier():
	var multiplier_added : Potion = Potion.new()
	multiplier_added.blue_multiplier = card_resource.blue_multiply
	multiplier_added.green_multiplier = card_resource.green_multiply
	multiplier_added.red_multiplier = card_resource.red_multiply
	card_multiplier_added.emit(multiplier_added)

func add_color():
	var color_added : Potion = Potion.new()
	color_added.add_blue(card_resource.blue_add)
	color_added.add_green(card_resource.green_add)
	color_added.add_red(card_resource.red_add)
	card_color_added.emit(color_added)

#WARNING: Only use when in hand.
func discard_self() -> void:
	DiscardPile.add_card(HandPile.take_card(card_resource))
	queue_free()

#NOTE: Update for non energy costs later
func pay_cost() -> void:
	Global.add_energy(-card_resource.energy_cost) 

#endregion

func _ready() -> void:
	card_color_added.connect(PotionHolder.on_card_color_added)
	card_multiplier_added.connect(PotionHolder.on_card_multiplier_added)

#region incoming signals
func _on_button_button_down() -> void:
	attempt_activation()

#WARNING: Animation breaks if moused over too fast
func _on_button_mouse_entered() -> void:
	animation.play("focus_card")

func _on_button_mouse_exited() -> void:
	animation.play_backwards("focus_card")

#endregion
