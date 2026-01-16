extends Node2D

@export var CustomerData: CustomerData
var current_request: Dictionary

func _ready() -> void:
	$Sprite2D.texture = CustomerData.sprite
