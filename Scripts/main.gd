extends Node2D



func _ready() -> void:
	await get_tree().process_frame
	if Global.joy_warning_yesterday:
		show_warning_dialog("JOY")
	elif Global.anguish_warning_yesterday:
		show_warning_dialog("ANGUISH")
	else:
		start_day()
	
func show_warning_dialog(type: String):
	var text = _build_warning_text(type)
	var dialog = DialogManager.start_dialog(text, get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(_on_dialog_finished)

func _build_warning_text(type: String) -> Array[String]:
	var text: Array[String]
	match type:
		"JOY": 
			text = ["Joy was too low, warning text here!"]
		"ANGUISH":
			text = ["Anguish was too low, warning text here!"]
		_:
			text = ["no text"]
	return text

func _on_dialog_finished():
	start_day()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")
	
func start_day():
	$UIControl/JoyAnguishMeters.update()
	await get_tree().create_timer(0.5).timeout
	$CustomerManager.spawn_customer()
	print(Global.day)
