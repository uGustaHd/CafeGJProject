extends Control

@onready var day_label: Label = $DayCounter/Label
@onready var customer_label: Label = $CustomerCounter/Label


func update_day():
	day_label.text = "Day " + str(Global.day)
func update_customer(customer_per_day: int, customers_served_today: int):
	customer_label.text = str(customers_served_today) + " / " + str(customer_per_day)
