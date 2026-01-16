extends Node2D

@export var customer_data: CustomerData
var current_request: Dictionary

func setup():
	if customer_data != null:
		$Sprite2D.texture = customer_data.sprite
		current_request = customer_data.possible_requests.pick_random()
	else:
		print("No CustomerData")

func _ready() -> void:
	setup()
