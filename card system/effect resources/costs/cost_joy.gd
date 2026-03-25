extends CardCost
class_name CostJoy


func check_cost(_router : EffectRouter, card : Card) -> bool:
	if Global.joy >= card.joy_cost:
		return true
	else:
		return false
	
func pay_cost(_router : EffectRouter, card : Card) -> void:
	Global.add_joy(-card.joy_cost)
	
func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.cost = self
	new_cost_icon.number = card.joy_cost
	new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/JoyCost.png")
	return new_cost_icon
