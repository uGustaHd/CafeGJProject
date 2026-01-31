extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer

func _ready() -> void:
	#NOTE: Visual bug for some reason
	animation_player.play("fade_out")
	
	audio_stream_player_2d.stream.loop = true
	audio_stream_player_2d.play()
#TODO: Add the assets


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
