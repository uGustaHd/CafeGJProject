extends Control

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var button : Button = $Visuals/Button

@onready var effect_text : RichTextLabel = $Visuals/Base/EffectText
@onready var title : RichTextLabel = $Visuals/Art/Title
@onready var energy_cost : RichTextLabel = $Visuals/CostIcon/EnergyCost
@onready var art : TextureRect = $Visuals/Art

var price : int = 10
var card_resource : Card

func _ready():
	button.pressed.connect(_on_pressed)

func _on_pressed():
	if Global.gold < price:
		return
	Global.add_gold(-price)
	Global.run_deck.append(card_resource)
	queue_free()

func initialize_card(source_card : Card) -> void:
	card_resource = source_card

	art.texture = card_resource.card_art
	color_title()

	if card_resource.archetype != card_resource.Archetype.RAINBOW:
		title.add_text(card_resource.title)

	energy_cost.text = str(card_resource.energy_cost)

	fill_effect_text()
	effect_text.add_text(card_resource.effect_text)
	
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

func _on_button_mouse_entered() -> void:
	animation.play("focus_card")

func _on_button_mouse_exited() -> void:
	animation.play_backwards("focus_card")
