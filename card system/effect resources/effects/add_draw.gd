extends CardEffect
class_name AddDraw


func activate(router : EffectRouter, card : Card) -> void:
	router.Dealer.deal_cards(card.draw_add)
	
func get_text(card : Card) -> String:
	var effect_text : String = "+ " + str(card.draw_add)
	return effect_text
