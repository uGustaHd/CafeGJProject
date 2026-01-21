extends Node


@onready var DeckHolder = get_parent()
@onready var HandHolder = $"../../HandHolder"
var hand_size : int = 5

func deal_cards(cards_to_deal : int):
	for card in cards_to_deal:
		# remove cards from draw pile, add them to hand pile 
		HandHolder.add_card_to_hand(DeckHolder.draw_card())
		
func on_customer_spawned():
	deal_cards(hand_size)
