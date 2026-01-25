extends Node2D
@export var talk_texts: Array[String]
@export var tip_texts: Array[String]
@onready var dialog_position = $DialogPosition
@onready var gold_label = $Control/Gold/Label


func _ready() -> void:
	Global.gold_changed.connect(update_gold)
	update_gold(Global.gold)

func update_gold(value : int):
	gold_label.text ="Gold: " + str(value)
	
func _on_button_talk_pressed() -> void:
	var dialog_box = DialogManager.start_dialog(talk_texts, dialog_position.position)
	dialog_box.set_custom_minimum(Vector2(527, 50))

func _on_button_tips_pressed() -> void:
	var dialog_box = DialogManager.start_dialog(tip_texts, dialog_position.position)
	dialog_box.set_custom_minimum(Vector2(527, 50))


func _on_next_day_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
