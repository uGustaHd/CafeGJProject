extends Node

@onready var shop_hbox1 : HBoxContainer = $"../ShopHBox"
@onready var shop_hbox2 : HBoxContainer = $"../ShopHBox2"
@onready var CardGeneric = preload("res://shop_card_generic.tscn")
var cards_per_shop : int = 3

#NOTE: Shop pool last updated: 1/30/2026
var shop_pool : Array[Card] = [
	#Blue
	load("res://card system/card resources/blue/delphinium.tres"),
	load("res://card system/card resources/blue/water.tres"),
	#Red
	load("res://card system/card resources/red/dried_peppers.tres"),
	load("res://card system/card resources/red/mushrooms.tres"),
	load("res://card system/card resources/red/spider_legs.tres"),
	load("res://card system/card resources/red/nutmeg.tres"),
	#Green
	load("res://card system/card resources/green/sage_flower.tres"),
	load("res://card system/card resources/green/frog_eggs.tres"),
	#Gold
	load("res://card system/card resources/gold/pixie_dust.tres"),
	#Purple
	load("res://card system/card resources/purple/snake_fangs.tres"),
	load("res://card system/card resources/purple/soul_essence.tres"),
	#Rainbow
	load("res://card system/card resources/rainbow/roots.tres"),
	load("res://card system/card resources/rainbow/salamander.tres"),
]

func spawn_shop():
	for i in cards_per_shop:
		var card_resource : Card = shop_pool.pick_random()
		var card_ui = CardGeneric.instantiate()
		shop_hbox1.add_child(card_ui)
		card_ui.initialize_card(card_resource)
	for i in cards_per_shop:
		var card_resource : Card = shop_pool.pick_random()
		var card_ui = CardGeneric.instantiate()
		shop_hbox2.add_child(card_ui)
		card_ui.initialize_card(card_resource)

func _ready():
	spawn_shop()
