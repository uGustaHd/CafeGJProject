extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var day_begins_audio: AudioStream = preload("res://Assets/Audio/Music/Day Begins op 2.mp3")
@export var day_ends_audio: AudioStream = preload("res://Assets/Audio/Music/Day Ends op2.mp3")

func _ready() -> void:
	if Global.game_mode == Global.GameMode.NORMAL:
		Global.can_play_cards = true
		await get_tree().process_frame
		if Global.joy_warning_yesterday:
			show_warning_dialog("JOY")
		elif Global.anguish_warning_yesterday:
			show_warning_dialog("ANGUISH")
		else:
			start_day()
	else:
		pass
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
	$UIControl/DayCustomerCounter.update_day()
	$UIControl/JoyAnguishMeters.update()
	audio_stream_player_2d.stream = day_begins_audio
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	await get_tree().create_timer(0.5).timeout
	$CustomerManager.start_day()
	print(Global.day)
	
func end_day():
	audio_stream_player_2d.stream = day_begins_audio
	audio_stream_player_2d.play()
