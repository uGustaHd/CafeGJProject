extends CardEffect
class_name AddKill


func activate(_router : EffectRouter, card : Card) -> void:
	Global.add_kill(card.kill_add)
	
func get_text(card : Card) -> String:
	var effect_text : String
	if card.kill_add >= 0:
		effect_text = "+" + str(card.kill_add) + " Kill \n"
	elif card.kill_add < 0:
		effect_text = "-" + str(card.kill_add) + " Kill \n"
	return effect_text
