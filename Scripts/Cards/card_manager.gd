extends Node2D
#Replace with the correct CardManager
#For testing only

@onready var PotionHolder : Node = $PotionHolder
@onready var current_potion : Potion = PotionHolder.held_potion

signal potion_delivered(potion : Potion)

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_up"): 
		#var card_dict = {
			#"Blue": 1,
			#"Green" : 2,
			#"Red"  : 1
		#}
		#deliver_potion(card_dict)
		#print("Input emulateded: \n1x Blue\n2x Green\n1x Red")
	#elif Input.is_action_just_pressed("ui_down"):
		#var card_dict = {
			#"Blue": 1,
			#"Green" : 1,
			#"Red"  : 2
		#}
		#deliver_potion(card_dict)
		#print("Input emulateded: \n1x Blue\n1x Green\n2x Red")

func deliver_potion():
	potion_delivered.emit(current_potion)
	PotionHolder.reset_potion()
