extends Resource
class_name CardCost


func check_cost(_router : EffectRouter, _card : Card) -> bool:
	push_error("Cost not set")
	return false

func pay_cost(_router : EffectRouter, _card : Card) -> void:
	push_error("Cost not set")

func get_icon(_card : Card) -> CostIcon:
	push_error("Cost icon not set")
	return CostIcon.new()
