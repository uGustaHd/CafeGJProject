extends Resource
class_name CardEffect


func activate(_router : EffectRouter, _card : Card) -> void:
	push_error("Effect not set")

func get_text(_card : Card) -> String:
	push_error("Effect text not set")
	return "Effect text not set"
