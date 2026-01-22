extends HBoxContainer


var max_separation : int = 120
var min_separation : int = 100


# WARNING: Not thoroughly tested for all hand sizes
func adjust_separation():
	var new_separation : int = max_separation - (get_child_count() * 6)
	new_separation = max(new_separation, min_separation)
	add_theme_constant_override("separation", new_separation)

func _on_child_entered_tree(_node: Node) -> void:
	adjust_separation()

func _on_child_exiting_tree(_node: Node) -> void:
	adjust_separation()
