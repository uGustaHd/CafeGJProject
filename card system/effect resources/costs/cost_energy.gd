extends CardCost
class_name CostEnergy


func check_cost(card : Card) -> bool:
	if Global.energy >= (card.energy_cost + Global.fatigue):
		return true
	else:
		return false

func pay_cost(card : Card) -> void:
	Global.add_energy(-(card.energy_cost + Global.fatigue))

func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.number = card.energy_cost
	return new_cost_icon
