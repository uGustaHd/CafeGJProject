extends CardEffect
class_name AddEnergy


func activate(_router : EffectRouter, card : Card) -> void:
	Global.add_energy(card.energy_add)

func get_text(card : Card) -> String:
	var effect_text : String
	if card.energy_add > 0:
		effect_text = "+" + str(card.energy_add) + " Energy"
	elif card.energy_add < 0:
		effect_text = "-" + str(card.energy_add) + " Energy"
	return effect_text
