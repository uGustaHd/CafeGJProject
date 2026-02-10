extends CardEffect
class_name AddGold
# Adds gold directly, not when potion sold.


func activate(_router : EffectRouter, card : Card) -> void:
	Global.add_gold(card.gold_add)
	
func get_text(card : Card) -> String:
	var effect_text : String
	if card.gold_add >= 0:
		effect_text = "+" + str(card.gold_add) + " Gold \n"
	elif card.gold_add < 0:
		effect_text = "-" + str(card.gold_add) + " Gold \n"
	return effect_text
