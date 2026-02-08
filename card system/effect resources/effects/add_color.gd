extends CardEffect
class_name AddColor


enum ColorAdd {RED, GREEN, BLUE}
@export var color : ColorAdd
@export var amount : int = 1

func activate(router : EffectRouter) -> void:
	var potion_to_add : Potion = Potion.new()
	match color:
		ColorAdd.RED:
			potion_to_add.add_red(amount)
		ColorAdd.GREEN:
			potion_to_add.add_green(amount)
		ColorAdd.BLUE:
			potion_to_add.add_blue(amount)
	
	router.PotionHolder.add_colors(potion_to_add)

func get_text() -> String:
	var text_to_add : String = "+ "
	text_to_add += str(amount) + " "
	match color:
		ColorAdd.RED:
			text_to_add += "Red"
		ColorAdd.GREEN:
			text_to_add += "Green"
		ColorAdd.BLUE:
			text_to_add += "Blue"
	return text_to_add
