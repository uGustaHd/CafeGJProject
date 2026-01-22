extends Control

#region data
var card_resource : Card

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

func activate() -> void:
	queue_free()

#region incoming signals
func _on_button_button_down() -> void:
	activate()

#WARNING: Animation breaks if moused over too fast
func _on_button_mouse_entered() -> void:
	animation.play("focus_card")

func _on_button_mouse_exited() -> void:
	animation.play_backwards("focus_card")

#endregion
