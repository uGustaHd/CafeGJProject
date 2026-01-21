extends Control

@onready var joy_progress_bar = $JoyProgressBar
@onready var anguish_progress_bar = $AnguishProgressBar
func update():
	var tween = get_tree().create_tween()
	tween.tween_property(joy_progress_bar, "value", Global.joy, 0.4)
	tween.tween_property(anguish_progress_bar, "value", Global.anguish, 0.4)
