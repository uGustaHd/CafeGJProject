extends Resource
class_name Pile


# WARNING: If piles get very large, they may cause lag. May need to use dict in future.
var card_array : Array[Card]

# Will return is_empty card if empty
func take_random() -> Card:
	if not card_array.is_empty():
		var chosen_card = card_array.pick_random()
		card_array.erase(chosen_card)
		return chosen_card
	else:
		return load("res://card system/card resources/is_empty.tres")

# Removes all cards, gives them somewhere else.
func take_all() -> Array:
	var full_pile = card_array.duplicate()
	card_array.clear()
	return full_pile
		
func add_card(added_card : Card):
	card_array.append(added_card)
