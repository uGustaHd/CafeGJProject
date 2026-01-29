extends TextureRect

@onready var meter : ProgressBar = $ProgressBar

var pos_open := Vector2(1027, 252) 
var pos_closed := Vector2(1142, 252)

func _ready() -> void:
	pos_closed = position
	pos_open = pos_closed - Vector2(70,0)
	
	add_to_group("kill_ui")
	
func _on_arrow_button_pressed() -> void:
	var tween = get_tree().create_tween()
	if position == pos_open:
		tween.tween_property(self, "position", pos_closed, 0.5).set_trans(Tween.TRANS_BACK)
	else:
		tween.tween_property(self, "position", pos_open, 0.5).set_trans(Tween.TRANS_BACK)
	
func update_meter():
	meter.value = Global.kill

#region Incoming Signals
func _on_kill_button_button_down() -> void:
	Global.energy = Global.default_energy
	
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_click.png")
	)

func _on_kill_button_button_up() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)

func _on_kill_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_hover.png")
	)

func _on_kill_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1.png")
	)


#endregion
