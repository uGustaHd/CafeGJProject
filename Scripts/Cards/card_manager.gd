extends Node2D


signal potion_delivered(potion : Potion)

@onready var PotionHolder : Node = $PotionHolder
@onready var current_potion : Potion = PotionHolder.held_potion

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		deliver_potion()

func deliver_potion():
	potion_delivered.emit(current_potion)
	PotionHolder.reset_potion()
