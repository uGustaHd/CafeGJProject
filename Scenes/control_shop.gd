extends Node2D
@export var talk_texts: Array[String]
@export var tip_texts: Array[String]
@onready var dialog_position = $DialogPosition
@onready var gold_label = $Control/Gold/Label
@onready var dialog_box: MarginContainer = $Control/DialogBox



func _ready() -> void:
	Global.gold_changed.connect(update_gold)
	update_gold(Global.gold)

func update_gold(value : int):
	gold_label.text = "Gold: " + str(value)
	
func _on_button_talk_pressed() -> void:
	dialog_box.start_dialog(talk_texts)

func _on_button_tips_pressed() -> void:
	dialog_box.start_dialog(tip_texts)


func _on_next_day_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
