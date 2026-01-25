extends TextureRect


@onready var number_display : RichTextLabel = $RichTextLabel

func _ready() -> void:
	number_display.text = str(Global.energy)
	add_to_group("energy_ui")
	
func update_counter():
	number_display.text = str(Global.energy)
