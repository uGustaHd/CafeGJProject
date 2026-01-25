extends Node2D
class_name PileHolder


var held_pile : Pile = Pile.new()

func _process(_delta: float) -> void:
	if OS.is_debug_build():
		if Input.is_action_just_pressed("debug_piles"):
			var string_to_print : String = name + ": "
			for card : Card in held_pile.card_array:
				string_to_print += card.title + ", "
			print(string_to_print)
			if name == "DiscardHolder":
				print("\n")
