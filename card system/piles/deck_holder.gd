extends PileHolder


@onready var DiscardHolder = $"../DiscardHolder"
var is_looping : bool = false

var starting_deck : Array[Card] = [
load("res://card system/card resources/delphinium.tres"),
load("res://card system/card resources/dried_peppers.tres"),
load("res://card system/card resources/mushrooms.tres"),
load("res://card system/card resources/roots.tres"),
load("res://card system/card resources/sage_flower.tres"),
load("res://card system/card resources/water.tres"),
load("res://card system/card resources/water.tres"),
load("res://card system/card resources/water.tres"),
load("res://card system/card resources/water.tres"),
load("res://card system/card resources/water.tres"),
]

# WARNING: Will draw empty card if shuffle in discard fails to make deck pile not empty.
func draw_card() -> Card:
	var drawn_card = held_pile.take_random()
	if drawn_card == load("res://card system/card resources/is_empty.tres") and not is_looping:
		shuffle_in_discard()
		is_looping = true
		return draw_card()
	elif is_looping:
		push_warning("All cards in hand, cannot draw")
		return drawn_card
	else:
		is_looping = false
		return drawn_card

func shuffle_in_discard():
	var discarded_cards = DiscardHolder.held_pile.take_all()
	held_pile.card_array.append_array(discarded_cards)

func _ready() -> void:
	# If player has no cards, they get the starting deck on scene ready
	if held_pile.card_array.is_empty():
		held_pile.card_array = starting_deck.duplicate()
