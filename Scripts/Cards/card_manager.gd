extends Node2D
#Replace with the correct CardManager
#For testing only


signal potion_delivered(potion : Potion)

@onready var PotionHolder : Node = $PotionHolder
@onready var current_potion : Potion = PotionHolder.held_potion

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_select"):
		deliver_potion()

func deliver_potion():
	potion_delivered.emit(current_potion)
	PotionHolder.reset_potion()
