extends PileHolder


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var DiscardHolder = $"../DiscardHolder"

var draw_card_sound := preload("res://Assets/Audio/FX/draw_card_3.mp3")
var shuffle_card_sound := preload("res://Assets/Audio/FX/shuffle_1 .mp3")
var is_looping : bool = false

@export var starting_deck : Array[Card]

# NOTE: Will draw empty card if shuffle in discard fails to make deck pile not empty.
func draw_card() -> Card:
	var drawn_card = held_pile.take_random()
	if drawn_card == load("res://card system/card resources/is_empty.tres") and not is_looping:
		shuffle_in_discard()
		is_looping = true
		return draw_card()
	elif drawn_card == load("res://card system/card resources/is_empty.tres") and is_looping:
		push_warning("All cards in hand, cannot draw")
		return drawn_card
	else:
		audio_stream_player_2d.stream = draw_card_sound
		audio_stream_player_2d.play()
		is_looping = false
		return drawn_card

func shuffle_in_discard():
	audio_stream_player_2d.stream = shuffle_card_sound
	audio_stream_player_2d.play()
	var discarded_cards = DiscardHolder.held_pile.take_all()
	held_pile.card_array.append_array(discarded_cards)

func _ready() -> void:
	if Global.day == 1:
		Global.reset_run_deck(starting_deck)
	if held_pile.card_array.is_empty():
		if not Global.run_deck.is_empty():
			held_pile.card_array = Global.run_deck.duplicate()
		else:
			held_pile.card_array = starting_deck.duplicate()
