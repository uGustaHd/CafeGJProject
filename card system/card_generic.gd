extends Control

signal card_color_added(color_potion : Potion)
#region data
var card_resource : Card

@onready var DiscardPile : Pile = $"../../../../DiscardHolder".held_pile
@onready var PotionHolder = $"../../../../PotionHolder"
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var button : Button = $Visuals/Button

@onready var effect_text : RichTextLabel = $Visuals/Base/EffectText
@onready var title : RichTextLabel = $Visuals/Art/Title
@onready var energy_cost : RichTextLabel = $Visuals/CostIcon/EnergyCost
@onready var art : TextureRect = $Visuals/Art
#endregion

#region fill card
# Called by HandHolder once card resource is added.
func initialize_card(source_card : Card) -> void:
	card_resource = source_card
	art.texture = card_resource.card_art
	title.text = card_resource.title
	energy_cost.text = str(card_resource.energy_cost)
	effect_text.text = card_resource.effect_text
	fill_additional_costs()
	fill_effect_text()

#TODO: If card has costs other that energy, should add those icons to card.
func fill_additional_costs() -> void:
	pass
	
#TODO: Should generate text for numerical effects
func fill_effect_text() -> void:
	pass

#endregion

#region actions
func activate() -> void:
	var color_added : Potion = Potion.new()
	color_added.add_blue(card_resource.blue_add)
	color_added.add_green(card_resource.green_add)
	color_added.add_red(card_resource.red_add)
	card_color_added.emit(color_added)
	
	discard_self()
	pay_cost()
	
func discard_self() -> void:
	DiscardPile.add_card(card_resource)
	queue_free()

#NOTE: Update for non energy costs later
func pay_cost() -> void:
	Global.add_energy(-card_resource.energy_cost) 

#endregion

func _ready() -> void:
	card_color_added.connect(PotionHolder.on_card_color_added)
	#add_to_group("Cards")

#region incoming signals
func _on_button_button_down() -> void:
	activate()

#WARNING: Animation breaks if moused over too fast
func _on_button_mouse_entered() -> void:
	animation.play("focus_card")

func _on_button_mouse_exited() -> void:
	animation.play_backwards("focus_card")

#endregion
