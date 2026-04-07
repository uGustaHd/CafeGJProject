extends CardCost
class_name CostMultiplier


@export var cost_color : GlobalNames.RGBColors

func check_cost(_router : EffectRouter, _card : Card) -> bool:
	# Can always have lower multiplier
	return true
	
func pay_cost(router : EffectRouter, card : Card) -> void:
	var potion_add : Potion = Potion.new()
	match cost_color:
		GlobalNames.RGBColors.RED:
			potion_add.red_multiplier = -card.red_multiplier_cost
			potion_add.green_multiplier = 0
			potion_add.blue_multiplier = 0
			
		GlobalNames.RGBColors.GREEN:
			potion_add.green_multiplier = -card.green_multiplier_cost
			potion_add.red_multiplier = 0
			potion_add.blue_multiplier = 0
			
		GlobalNames.RGBColors.BLUE:
			potion_add.blue_multiplier = -card.blue_multiplier_cost
			potion_add.red_multiplier = 0
			potion_add.green_multiplier = 0
			
	router.PotionHolder.cost_multiplier(potion_add)
	print_debug("Mult cost payed")
	
func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.cost = self
	match cost_color:
		GlobalNames.RGBColors.RED:
			new_cost_icon.number = card.red_multiplier_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/RedMultCost.png")
			
		GlobalNames.RGBColors.GREEN:
			new_cost_icon.number = card.green_multiplier_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/GreenMultCost.png")
			
		GlobalNames.RGBColors.BLUE:
			new_cost_icon.number = card.green_multiplier_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/BlueMultCost.png")
		
	return new_cost_icon
