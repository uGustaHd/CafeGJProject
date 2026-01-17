extends Node2D

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$CustomerManager.spawn_customer()
	
