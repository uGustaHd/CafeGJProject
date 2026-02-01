extends Node2D
@onready var low_joy_cutscene: Sprite2D = $LowJoyCutscene
@onready var day_back_ground: Sprite2D = $DayBackGround
@onready var day_background_counter: Sprite2D = $DayBackgroundCounter
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var low_anguish_cutscene: Sprite2D = $LowAnguishCutscene
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


var audio = preload("res://Assets/Audio/Music/Day Ends op2.mp3")


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
	"They come at night, no longer whispering your name",
	"Torches are thrown, and your hut catches fire in an instant",
	"The flames rise, and the village takes back what it believes you stole",
]


var text_anguish : Array[String] = [
	"You grew soft, little witch. Their pain no longer feeds me",
	"I gave you power, and you answered with mercy",
	"Come. Your suffering will make up for what you denied me",
]

func _ready() -> void:
	audio_stream_player_2d.stream = audio
	audio_stream_player_2d.play()
	print(get_viewport_rect().size/2)
	text_position.y += 10
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
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

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
		
