extends CardEffect
class_name FlipMultiplier


func activate(router : EffectRouter, card : Card) -> void:
	var multiplier_potion : Potion = Potion.new()
	if card.flip_red_multiply: multiplier_potion.red_multiplier = -1
	if card.flip_green_multiply: multiplier_potion.green_multiplier = -1
	if card.flip_blue_multiply: multiplier_potion.blue_multiplier = -1
	
	router.PotionHolder.switch_multipliers(multiplier_potion)

func get_text(card : Card) -> String:
	var effect_text : String = ""
	if card.flip_red_multiply:
		effect_text += "Flip Red X \n"
		
	if card.flip_green_multiply:
		effect_text += "Flip Green X \n"
		
	if card.flip_red_multiply:
		effect_text += "Flip Blue X \n"
	
	return effect_text
