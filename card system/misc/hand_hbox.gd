extends HBoxContainer


var max_separation : int = 100


func adjust_separation():
	var new_seperation : int = max_separation / get_child_count()
	add_theme_constant_override("separation", new_seperation)
	print_debug("hand separation adjusted")


func _on_child_entered_tree(node: Node) -> void:
	adjust_separation()

func _on_child_exiting_tree(node: Node) -> void:
	adjust_separation()
