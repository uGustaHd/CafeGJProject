extends CardEffect
class_name AddJoy


func activate(_router : EffectRouter, card : Card) -> void:
	Global.add_joy(card.joy_add)
	
func get_text(card : Card) -> String:
	var effect_text : String
	if card.joy_add >= 0:
		effect_text = "+" + str(card.joy_add) + " Joy \n"
	elif card.joy_add < 0:
		effect_text = "-" + str(card.joy_add) + " Joy \n"
	return effect_text
