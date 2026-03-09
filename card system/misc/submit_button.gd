extends TextureButton


func _on_button_down() -> void:
	if Global.can_play_cards:
		Global.reset_fatigue()
		Global.energy = Global.default_energy
		# To update energy meter
		Global.add_energy(0)
		
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
