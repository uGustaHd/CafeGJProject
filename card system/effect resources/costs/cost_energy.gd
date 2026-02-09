extends CardCost
class_name CostEnergy


@export var amount : int

func pay() -> bool:
	if Global.energy >= amount:
		Global.add_energy(-amount)
		return true
	else:
		return false

func get_icon() -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.number = amount
	return new_cost_icon
