extends CardEffect
class_name AddAnguish


func activate(_router : EffectRouter, card : Card) -> void:
	Global.add_anguish(card.anguish_add)
	
func get_text(card : Card) -> String:
	var effect_text : String
	if card.anguish_add >= 0:
		effect_text = "+" + str(card.anguish_add) + " Anguish \n"
	elif card.anguish_add < 0:
		effect_text = "-" + str(card.anguish_add) + " Anguish \n"
	return effect_text
