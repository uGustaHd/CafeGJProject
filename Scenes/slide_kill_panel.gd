extends TextureRect

var pos_open := Vector2(1027, 252) 
var pos_closed := Vector2(1142, 252)

func _on_arrow_button_pressed() -> void:
	
	var tween = get_tree().create_tween()
	if position == pos_open:
		tween.tween_property(self, "position", pos_closed, 0.5).set_trans(Tween.TRANS_BACK)
	else:
		tween.tween_property(self, "position", pos_open, 0.5).set_trans(Tween.TRANS_BACK)
	
