extends Control

func _ready() -> void:
	
	visible = false
func report_day():
	$Information/InformationNameLabel.text = _build_info_name_text()
	$Information/InformationValueLabel.text = _build_info_value_text()
	if Global.anguish >= 20:
		$PatronInfo/Label.text = "The patron is satiated for today"
	else:
		$PatronInfo/Label.text = "The patron isn't stiated for today"
	visible = true
	
func _build_info_name_text() -> String:
	return " Gold\n Plesed Customers\n Secret Ingredients Added\n Killed Customers\n Cards Used\n Cards Remaining"
	
func _build_info_value_text() -> String:
	return str(Global.gold) + "\n" + str(Global.plesed_customers) + "\n" + str(Global.secret_ingredients_added) + "\n" + str(Global.killed_customers) + "\n" + str(Global.cards_used) + "\n" + str(Global.cards_remaining)
	
