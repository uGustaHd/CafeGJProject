extends CardCost
class_name CostColor
# Used to create re, green, blue costs

@export var cost_color : GlobalNames.RGBColors

func check_cost(router : EffectRouter, card : Card) -> bool:
	match cost_color:
		GlobalNames.RGBColors.RED:
			if router.PotionHolder.held_potion.red >= card.red_cost:
				return true
				
		GlobalNames.RGBColors.GREEN:
			if router.PotionHolder.held_potion.green >= card.green_cost:
				return true
				
		GlobalNames.RGBColors.BLUE:
			if router.PotionHolder.held_potion.blue >= card.blue_cost:
				return true
				
	return false
	
func pay_cost(router : EffectRouter, card : Card) -> void:
	var potion_add : Potion = Potion.new()
	# NOTE: Cannot be consolidated into one statement because the distinction provided
	# by the export var allows card to easily have multiple color costs and cost icons.
	match cost_color:
		GlobalNames.RGBColors.RED:
			potion_add.add_red(-card.red_cost)
			
		GlobalNames.RGBColors.GREEN:
			potion_add.add_green(-card.green_cost)
			
		GlobalNames.RGBColors.BLUE:
			potion_add.add_blue(-card.blue_cost)
			
	router.PotionHolder.cost_colors(potion_add)
			
func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
	new_cost_icon.cost = self
	match cost_color:
		GlobalNames.RGBColors.RED:
			new_cost_icon.number = card.red_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/RedCost.png")
			
		GlobalNames.RGBColors.GREEN:
			new_cost_icon.number = card.green_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/GreenCost.png")
			
		GlobalNames.RGBColors.BLUE:
			new_cost_icon.number = card.green_cost
			new_cost_icon.icon = load("res://card system/card_assets/card_art/cost icons/BlueCost.png")
		
	return new_cost_icon
