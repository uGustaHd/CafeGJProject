extends CardEffect
class_name AddColor


func activate(router : EffectRouter, card : Card) -> void:
	var color_added : Potion = Potion.new()
	color_added.add_blue(card.blue_add)
	color_added.add_green(card.green_add)
	color_added.add_red(card.red_add)
	
	router.PotionHolder.add_colors(color_added)

func get_text(card : Card) -> String:
	var numerical_strings : Array[String] = [
		" Red \n",
		" Green \n",
		" Blue \n",
		]
	var effect_text : String = ""
	var colors : Array[int] = [card.red_add, card.green_add, card.blue_add]
	var i = 0
	for value in colors:
		if value != 0:
			var text_to_add : String = numerical_strings[i]
			if value > 0:
				text_to_add = "+" + str(value) + text_to_add
			elif value < 0:
				text_to_add = "-" + str(value) + text_to_add
			effect_text += text_to_add
		i += 1
	return effect_text
	
