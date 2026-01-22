extends PileHolder


@onready var CardGeneric = preload("res://card system/card_generic.tscn")
@onready var HandUI = $HandUI
@onready var HBox = $HandUI/HandHBox

# Adds card to held_pile and spawns in card ui
func add_card_to_hand(added_card : Card):
	held_pile.add_card(added_card)
	spawn_card_ui(added_card)
	
func spawn_card_ui(spawned_card):
	var new_card_ui = CardGeneric.instantiate()
	HBox.add_child(new_card_ui)
	new_card_ui.initialize_card(spawned_card)
