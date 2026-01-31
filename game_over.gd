extends Node2D
@onready var low_joy_cutscene: Sprite2D = $LowJoyCutscene
@onready var day_back_ground: Sprite2D = $DayBackGround
@onready var day_background_counter: Sprite2D = $DayBackgroundCounter
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var low_anguish_cutscene: Sprite2D = $LowAnguishCutscene



var low_anguish_cutscenes := [
	preload("res://Assets/Sprites/Background/Low Anguish_cutscene1.png"),
	preload("res://Assets/Sprites/Background/Low Anguish_cutscene2.png"),
	preload("res://Assets/Sprites/Background/Low Anguish_cutscene3.png")
]
var cutscene_index: int = 0
var text_position = Vector2(576.0, 464.0)

var text_day : Array[String] = [
	"7 days! You won!"
]


var text_joy : Array[String] = [
	"The joy went to low, you lost"
]


var text_anguish : Array[String] = [
	"Anguish went to low, you lost",
	"Anguish went to low, you lost",
	"Anguish went to low, you lost"
]

func _ready() -> void:
	print(get_viewport_rect().size/2)
	text_position.y += 10
	Global.game_over_reason = Global.GameOver.DAY
	low_anguish_cutscene.visible = false
	low_joy_cutscene.visible = false
	day_back_ground.visible = false
	day_background_counter.visible = false
	match Global.game_over_reason:
		Global.GameOver.DAY:
			day_background_counter.visible = true
			day_back_ground.visible = true
			var dialog = DialogManager.start_dialog(text_day, text_position)
			dialog.dialog_finished.connect(_on_dialog_finished)
		Global.GameOver.JOY:
			low_joy_cutscene.visible = true
			var dialog = DialogManager.start_dialog(text_joy, text_position)
			dialog.dialog_finished.connect(_on_dialog_finished)
		Global.GameOver.ANGUISH:
			low_anguish_cutscene.visible = true
			day_background_counter.visible = true
			var dialog = DialogManager.start_dialog(text_anguish, text_position)
			dialog.text_changed.connect(_on_text_changed)
			dialog.dialog_finished.connect(_on_dialog_finished)

func _on_dialog_finished():
	animation_player.play("fade_in")
	print("Fim")

func _on_text_changed():
	match cutscene_index:
		0:
			animation_player.play("fade_in")
			await animation_player.animation_finished
			animation_player.play("fade_out")
			$LowAnguishCutscene.texture = low_anguish_cutscenes[1]
			cutscene_index += 1
		1:
			animation_player.play("fade_in")
			await animation_player.animation_finished
			animation_player.play("fade_out")
			$LowAnguishCutscene.texture = low_anguish_cutscenes[2]
			cutscene_index += 1
		2:
			cutscene_index += 1
		
func _on_play_button_pressed() -> void:
	Global.game_mode = Global.GameMode.NORMAL
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_credits_button_pressed() -> void:
	#TODO Credits scene
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
