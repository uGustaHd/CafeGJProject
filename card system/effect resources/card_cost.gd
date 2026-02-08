extends Resource
class_name CardCost


func pay() -> bool:
	push_error("Cost not set")
	return false


func get_icon() -> CostIcon:
	push_error("Cost icon not set")
	return CostIcon.new()
