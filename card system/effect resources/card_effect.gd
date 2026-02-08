extends Resource
class_name CardEffect


func activate(_router : EffectRouter) -> void:
	push_error("Effect not set")

func get_text() -> String:
	push_error("Effect text not set")
	return "Effect text not set"
