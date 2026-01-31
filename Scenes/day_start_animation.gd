extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label


func play_animation():
	print("play animation")
	label.text = "Day " + str(Global.day)
	animation_player.play("day_animation")
	return animation_player
