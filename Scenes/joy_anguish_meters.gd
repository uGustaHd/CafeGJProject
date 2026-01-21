extends TextureRect

@onready var joy_progress_bar = $JoyProgressBar
@onready var anguish_progress_bar = $AnguishProgressBar

func _process(_delta: float) -> void:
	joy_progress_bar.set_value(Global.joy)
	anguish_progress_bar.set_value(Global.anguish)
