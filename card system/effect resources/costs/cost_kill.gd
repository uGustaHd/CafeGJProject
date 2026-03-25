extends CardCost
class_name CostKill


func check_cost(_router : EffectRouter, card : Card) -> bool:
	if Global.kill >= card.kill_cost:
		return true
	else:
		return false

func pay_cost(_router : EffectRouter, card : Card) -> void:
	Global.add_kill(-card.kill_cost)
	
func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.cost = self
	new_cost_icon.number = card.kill_cost
	new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/KillCost.png")
	
	return new_cost_icon
