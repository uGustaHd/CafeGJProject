extends Node2D

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$CustomerManager.spawn_customer()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")
