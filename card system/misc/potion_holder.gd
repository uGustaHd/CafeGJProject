extends Node


@onready var SubmitButton : TextureButton = $SubmitButton

var held_potion : Potion = Potion.new()
var requested_potion : Potion
signal potion_progress_changed(potion: Potion)

#Test
func _process(_delta: float) -> void: pass
	#if Input.is_action_just_pressed("ui_up"):
		#held_potion.add_blue(1)
		#emit_signal("potion_progress_changed", held_potion)
		#print("blue = " + str(held_potion.blue))
	#if Input.is_action_just_pressed("ui_down"):
		#held_potion.add_green(1)
		#emit_signal("potion_progress_changed", held_potion)
		#print("green = " + str(held_potion.green))
	#if Input.is_action_just_pressed("ui_right"):
		#held_potion.add_red(1)
		#emit_signal("potion_progress_changed", held_potion)
		#print("red = " + str(held_potion.red))
	#
	#if Input.is_action_just_pressed("add_energy") and OS.is_debug_build():
		#Global.add_energy(1)
	#if Input.is_action_just_pressed("add_kill") and OS.is_debug_build():
		#Global.add_kill(1)

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

func add_multiplier(added_multiplier : Potion):
	held_potion.blue_multiplier *= added_multiplier.blue_multiplier
	held_potion.green_multiplier *= added_multiplier.green_multiplier
	held_potion.red_multiplier *= added_multiplier.red_multiplier
	potion_progress_changed.emit(held_potion)

func reset_potion():
	held_potion = Potion.new()
	emit_signal("potion_progress_changed", held_potion)
	
func on_card_color_added(color_added : Potion):
	# Called here because all cards add color, even if adding 0
	held_potion.on_card_played()
	add_colors(color_added)
	if held_potion.status == Potion.Status.VOLATILE:
		check_volatility()
	
func on_card_multiplier_added(multiplier_added : Potion):
	add_multiplier(multiplier_added)
	
func on_customer_spawned(customer_potion : Potion):
	held_potion.requested_potion = customer_potion
	requested_potion = customer_potion
	
	
