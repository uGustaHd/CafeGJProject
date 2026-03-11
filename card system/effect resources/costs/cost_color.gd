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
	match cost_color:
		GlobalNames.RGBColors.RED:
			router.PotionHolder.held_potion.red -= card.red_cost
			
		GlobalNames.RGBColors.GREEN:
			router.PotionHolder.held_potion.green -= card.green_cost
			
		GlobalNames.RGBColors.BLUE:
			router.PotionHolder.held_potion.blue -= card.blue_cost
			
func get_icon(card : Card) -> CostIcon:
	var new_cost_icon = CostIcon.new()
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
