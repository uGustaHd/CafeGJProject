extends Node
class_name PotionHold


@onready var SubmitButton : TextureButton = $SubmitButton

var held_potion : Potion = Potion.new()
var requested_potion : Potion
signal potion_progress_changed(potion: Potion)

#/##############################################################################

func check_volatility():
	var i = 0
	for color in held_potion.colors:
		if color > requested_potion.colors[i]:
			color = 0
			SubmitButton.button_down.emit()

func add_colors(added_colors : Potion) -> void:
	held_potion.add_blue(added_colors.blue)
	held_potion.add_green(added_colors.green)
	held_potion.add_red(added_colors.red)
	potion_progress_changed.emit(held_potion)
	
func cost_colors(added_colors : Potion) -> void:
	held_potion.cost_blue(added_colors.blue)
	held_potion.cost_green(added_colors.green)
	held_potion.cost_red(added_colors.red)
	potion_progress_changed.emit(held_potion)

# Multiplies if current multiplier is positive, adds if it is negative.
func apply_multiplier(added_multiplier : Potion):
	if held_potion.red_multiplier < 0 and added_multiplier.red_multiplier != 1:
		held_potion.add_red_multiplier(added_multiplier.red_multiplier)
	elif held_potion.red_multiplier > 0:
		held_potion.red_multiplier *= added_multiplier.red_multiplier
	
	if held_potion.green_multiplier < 0 and added_multiplier.green_multiplier != 1:
		held_potion.add_green_multiplier(added_multiplier.green_multiplier)
	elif held_potion.green_multiplier > 0:
		held_potion.green_multiplier *= added_multiplier.green_multiplier
		
	if held_potion.blue_multiplier < 0 and added_multiplier.blue_multiplier != 1:
		held_potion.add_blue_multiplier(added_multiplier.blue_multiplier)
	elif held_potion.blue_multiplier > 0:
		held_potion.blue_multiplier *= added_multiplier.blue_multiplier
	
	potion_progress_changed.emit(held_potion)

# Multiplier potion has -1 for multipliers being switched, 1 for not.
func switch_multipliers(multiplier_potion : Potion):
	held_potion.red_multiplier *= multiplier_potion.red_multiplier
	held_potion.green_multiplier *= multiplier_potion.green_multiplier
	held_potion.blue_multiplier *= multiplier_potion.blue_multiplier

func cost_multiplier(added_multiplier : Potion):
	held_potion.add_red_multiplier(added_multiplier.red_multiplier)
	held_potion.add_green_multiplier(added_multiplier.green_multiplier)
	held_potion.add_blue_multiplier(added_multiplier.blue_multiplier)
	print_debug("cost mult applied from potion holder")
	
	potion_progress_changed.emit(held_potion)

func reset_potion():
	held_potion = Potion.new()
	emit_signal("potion_progress_changed", held_potion)

#/##############################################################################

func on_customer_spawned(customer_potion : Potion):
	held_potion.requested_potion = customer_potion
	requested_potion = customer_potion
	
#region debug
func _process(_delta: float) -> void:
	if OS.is_debug_build():
		if Input.is_action_just_pressed("debug_held_potion"):
			print_debug("rgb = ", held_potion.red, held_potion.green, held_potion.blue)
			print_debug("rgb multipliers = ", held_potion.red_multiplier, held_potion.green_multiplier, held_potion.blue_multiplier)
		
		if Input.is_action_just_pressed("add_red"):
			var new_potion : Potion = Potion.new()
			new_potion.add_red(1)
			add_colors(new_potion)

		if Input.is_action_just_pressed("add_green"):
			var new_potion : Potion = Potion.new()
			new_potion.add_green(1)
			add_colors(new_potion)
			
		if Input.is_action_just_pressed("add_blue"):
			var new_potion : Potion = Potion.new()
			new_potion.add_blue(1)
			add_colors(new_potion)

#endregion
