extends TextureRect


@onready var number_display : RichTextLabel = $RichTextLabel

func _ready() -> void:
	add_to_group("gold_ui")
	
func update_counter():
	number_display.text = str(Global.gold)
