extends Control

@onready var day_label: Label = $DayCounter/Label
@onready var customer_label: Label = $CustomerCounter/Label


func update_day():
	day_label.text = "Day " + str(Global.day)
func update_customer(customer_per_day: int, customers_served_today: int):
	# Added 1 so it would be clear when player was on last customer of the day
	customer_label.text = str(min(customers_served_today + 1, 3)) + " / " + str(customer_per_day)
