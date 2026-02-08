extends CardCost


@export var amount : int

func pay() -> void:
	Global.add_energy(-amount)

func get_icon() -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.number = amount
	return new_cost_icon
