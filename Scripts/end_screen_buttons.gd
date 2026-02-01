extends VBoxContainer


func _on_home_button_button_down() -> void:
	Global.reset()
	DialogManager.reset()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_restart_button_button_down() -> void:
	Global.reset()
	DialogManager.reset()
	Global.game_mode = Global.GameMode.NORMAL
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
