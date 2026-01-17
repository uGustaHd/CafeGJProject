extends Node2D
#Replace with the correct CardManager
#For testing only
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"): 
		var card_dict = {
			"Blue": 1,
			"Green" : 2,
			"Red"  : 1
		}
		deliver_cards(card_dict)
		print("- Deliver ui_up")
	elif Input.is_action_just_pressed("ui_down"):
		var card_dict = {
			"Blue": 1,
			"Green" : 1,
			"Red"  : 2
		}
		deliver_cards(card_dict)
		print("- Deliver ui_down")
signal item_delivered(card_dict: Dictionary)
func deliver_cards(card_dict: Dictionary):
	emit_signal("item_delivered", card_dict)
