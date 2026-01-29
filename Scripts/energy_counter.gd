extends TextureRect


@onready var number_display : RichTextLabel = $RichTextLabel
@onready var progress : TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	number_display.text = str(Global.energy)
	add_to_group("energy_ui")
	
func update_counter():
	number_display.text = str(Global.energy)
	progress.value = Global.energy
