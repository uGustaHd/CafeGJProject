extends Control
class_name CardGeneric


#region Initial Data
var card_resource : Card

@onready var Router
@onready var DiscardPile
@onready var HandPile
@onready var PotionHolder
@onready var Dealer

@onready var border : TextureRect = $Visuals/Border
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var button : Button = $Visuals/Button
@onready var cost_icon_container = $Visuals/CostIconContainer

@onready var effect_text : RichTextLabel = $Visuals/Base/EffectText
@onready var title : RichTextLabel = $Visuals/Art/Title
@onready var art : TextureRect = $Visuals/Art

#{RED, GREEN, BLUE, GOLD, PURPLE, RAINBOW}
@onready var borders : Array[Texture] = [
	load("res://card system/card_assets/card_art/New  Illusts/Red/Red_border.png"),
	load("res://card system/card_assets/card_art/New  Illusts/Green/Border_ver_1.png"),
	load("res://card system/card_assets/card_art/New  Illusts/Blue/Blue_border.png"),
	load("res://card system/card_assets/card_art/New  Illusts/Gold/Gold_border.png"),
	load("res://card system/card_assets/card_art/New  Illusts/Purple/Purple_border.png"),
	load("res://card system/card_assets/card_art/New  Illusts/Rainbow/Rainbow_border.png"),
	]

# Function necessary due to inability to override vars in child classes.
func fill_outside_vars():
	Router = $"../../../../EffectRouter"
	DiscardPile = $"../../../../DiscardHolder".held_pile
	HandPile = $"../../..".held_pile
	PotionHolder = $"../../../../PotionHolder"
	Dealer = $"../../../../DeckHolder/Dealer"

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
	add_cost_icons()
	update_cost_icons()
	fill_effect_text()
	effect_text.add_text(card_resource.effect_text)
	set_border()
	
func add_cost_icons() -> void:
	var icon_scene : PackedScene = load("res://card system/cost_icon.tscn")
	for cost : CardCost in card_resource.costs:
		var card_icon : CostIcon = cost.get_icon(card_resource)
		var new_icon = icon_scene.instantiate()
		new_icon.icon_resource = card_icon
		new_icon.texture = card_icon.icon
		new_icon.get_child(0).text = str(card_icon.number)

		cost_icon_container.add_child(new_icon)
	
func fill_effect_text() -> void:
	for effect : CardEffect in card_resource.effects:
		effect_text.add_text(effect.get_text(card_resource))
	
# Returns bool to check if text needed fitting
func fit_text() -> bool:
	return true

# Assigns title directly if Rainbow
func color_title() -> void:
	title.push_outline_size(4)
	title.push_outline_color(Color.BLACK)
	
	match card_resource.archetype:
		card_resource.Archetype.RED:
			title.push_color(Color.RED)
			
		card_resource.Archetype.BLUE:
			title.push_color(Color.DODGER_BLUE)
			
		card_resource.Archetype.GREEN:
			title.push_color(Color.LIME_GREEN)
			
		card_resource.Archetype.GOLD:
			title.push_color(Color.GOLDENROD)
			
		card_resource.Archetype.PURPLE:
			title.push_color(Color.REBECCA_PURPLE)
			
		card_resource.Archetype.RAINBOW:
			title.text = "[outline_color=BLACK][outline_size=4.0][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]" + card_resource.title + "[/rainbow]"

func set_border() -> void:
	border.texture = borders[card_resource.archetype]

#endregion

#region actions
func attempt_activation() -> bool:
	var can_activate : bool = true
	for cost : CardCost in card_resource.costs:
		if cost.check_cost(Router, card_resource) == false:
			can_activate = false
	return can_activate

func activate_effects() -> void:
	for effect : CardEffect in card_resource.effects:
		effect.activate(Router, card_resource)
		
	Global.cards_used += 1
	if card_resource.evil == true:
		Global.secret_ingredients_added += 1
		
	discard_self()

func pay_costs():
	for cost : CardCost in card_resource.costs:
		cost.pay_cost(Router, card_resource)
		
	for card in get_parent().get_children():
		card.update_cost_icons()

#WARNING: Only use when in hand.
func discard_self() -> void:
	DiscardPile.add_card(HandPile.take_card(card_resource))
	queue_free()

#endregion

func _ready() -> void:
	fill_outside_vars()
	add_to_group("cards")

#Updates color of cost icon text
func update_cost_icons():
	# Cycles thru icon generics attached to card
	for icon in cost_icon_container.get_children():
		# Energy cost case
		if icon.icon_resource.cost == load("res://card system/effect resources/costs/CostEnergy.tres"):
			update_fatigue(icon)
			if (card_resource.energy_cost + Global.fatigue) > Global.energy:
				icon.get_child(0).self_modulate = Color.RED
			else:
				icon.get_child(0).self_modulate = Color.WHITE
				
		# Color cost cases
		elif icon.icon_resource.cost == load("res://card system/effect resources/costs/CostRed.tres"):
			if card_resource.red_cost > Router.PotionHolder.held_potion.red:
				icon.get_child(0).self_modulate = Color.RED
			else:
				icon.get_child(0).self_modulate = Color.WHITE
		
		elif icon.icon_resource.cost == load("res://card system/effect resources/costs/CostGreen.tres"):
			if card_resource.green_cost > Router.PotionHolder.held_potion.green:
				icon.get_child(0).self_modulate = Color.RED
			else:
				icon.get_child(0).self_modulate = Color.WHITE
				
		elif icon.icon_resource.cost == load("res://card system/effect resources/costs/CostBlue.tres"):
			if card_resource.blue_cost > Router.PotionHolder.held_potion.blue:
				icon.get_child(0).self_modulate = Color.RED
			else:
				icon.get_child(0).self_modulate = Color.WHITE

func update_fatigue(icon):
	icon.get_child(0).text = str(card_resource.energy_cost + Global.fatigue)

#region incoming signals


func _on_button_button_down() -> void:
	if Global.can_play_cards:
		if attempt_activation():
			activate_effects()
			pay_costs()
	else: return
	#region UI Visuals
	#NOTE: Does not show up that well since card frees right after playing
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_click.png")
	)

func _on_button_button_up() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)

#WARNING: Animation breaks if moused over too fast
func _on_button_mouse_entered() -> void:
	animation.play("focus_card")
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_hover.png")
	)

func _on_button_mouse_exited() -> void:
	animation.play_backwards("focus_card")
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)
	#endregion
#endregion
