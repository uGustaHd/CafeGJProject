extends CardEffect
class_name AddMultiplier


func activate(router : EffectRouter, card : Card) -> void:
	var color_multiplied : Potion = Potion.new()
	color_multiplied.red_multiplier = card.red_multiply
	color_multiplied.green_multiplier = card.green_multiply
	color_multiplied.blue_multiplier = card.blue_multiply
	
	router.PotionHolder.add_multiplier(color_multiplied)

func get_text(card : Card) -> String:
	var numerical_strings : Array[String] = [
		" Red \n",
		" Green \n",
		" Blue \n",
		]
	var effect_text : String = ""
	var colors : Array[int] = [card.red_multiply, card.green_multiply, card.blue_multiply]
	var i = 0
	for value in colors:
		if value != 0:
			var text_to_add : String = numerical_strings[i]
			text_to_add = "X" + str(value) + text_to_add
			effect_text += text_to_add
		i += 1
	return effect_text
