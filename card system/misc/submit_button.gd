extends Button


func _on_button_down() -> void:
	Global.energy = Global.default_energy
	
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_click.png")
	)

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_hover.png")
	)

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)
