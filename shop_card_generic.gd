extends CardGeneric

@onready var price_label : Label = $Visuals/PricePanel/PriceLabel
var price : int


# Initializes shop card same as regular card, and then add price string.
func initialize_card(source_card : Card) -> void:
	super.initialize_card(source_card)
	price_label.text = str(price) + "g"
	
func _on_button_button_down() -> void:
	# Buy card
	if Global.gold < price:
		return
	Global.add_gold(-price)
	Global.run_deck.append(card_resource)
	queue_free()
	
	Input.set_custom_mouse_cursor(
		load("res://Assets/Sprites/UI/mouse_pointer/Cursor_ver1_click.png")
	)

# Ensures these functions won't affect shop cards.
func _ready() -> void:
	pass

func update_cost_icons():
	pass
	
func update_fatigue(_icon):
	pass
