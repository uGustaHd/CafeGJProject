extends Node
# NOTE: I'm handling the potion-building progress here for now,
# since this node already manages the potion state
# If this is not the ideal place, we can refactor it later

var held_potion : Potion = Potion.new()
signal potion_progress_changed(potion: Potion)

#Test
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		held_potion.add_blue(1)
		emit_signal("potion_progress_changed", held_potion)
		print("blue = " + str(held_potion.blue))
	if Input.is_action_just_pressed("ui_down"):
		held_potion.add_green(1)
		emit_signal("potion_progress_changed", held_potion)
		print("green = " + str(held_potion.green))
	if Input.is_action_just_pressed("ui_right"):
		held_potion.add_red(1)
		emit_signal("potion_progress_changed", held_potion)
		print("red = " + str(held_potion.red))

func add_colors(added_colors : Potion) -> void:
	held_potion.add_blue(added_colors.blue)
	held_potion.add_green(added_colors.green)
	held_potion.add_red(added_colors.red)
	potion_progress_changed.emit(held_potion)

func reset_potion():
	held_potion.reset_potion()
	emit_signal("potion_progress_changed", held_potion)
	
func on_card_color_added(color_added : Potion):
	add_colors(color_added)
