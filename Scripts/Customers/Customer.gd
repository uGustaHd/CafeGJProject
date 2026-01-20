extends Node2D

@export var customer_data: CustomerData
var current_request: Potion
var dialog_offset: Vector2 = Vector2(0,110)
var request_text: String
@onready var request_box = $RequestBox

signal finished
signal died

func setup():
	if customer_data != null:
		$Sprite2D.texture = customer_data.sprite
		#NOTE: Currently only generates a potion of difficulty 1 every time.
		current_request = customer_data.possible_requests.generate_potion(1)
		#request_text = _build_request_text(Potion.new()) #"I want \n" + str(current_request.get("Blue")) + "x Blue\n" +  str(current_request.get("Green")) + "x Green\n" + str(current_request.get("Red")) + "x Red" 
		request_box.visible = false
		request_box.position = position + Vector2(100,-50)
	else:
		print("No CustomerData")

func _ready() -> void:
	setup()
	print("\nCustomer Appeared")
	
	
	#TODO: Connect a signal with the potion that the player gave to the NPC
	var card_manager = get_tree().current_scene.get_node("CardManager")
	var potion_holder = card_manager.get_node("PotionHolder")
	card_manager.connect("potion_delivered", Callable(self, "_on_potion_delivered"))
	potion_holder.potion_progress_changed.connect(_on_potion_changed)
	
	await get_tree().process_frame
	var dialog = DialogManager.start_dialog(customer_data.dialog_intro, global_position + dialog_offset)
	await dialog.dialog_finished
	request_box.visible = true
	show_request(Potion.new())
	
#Signal
func _on_potion_delivered(potion : Potion) -> void: 
	var success : bool = true
	
	# NOTE: Recommend replace with check against a requested potion resource.
	# TODO: Replace request Dictionary with a RequestResource
	#if potion.blue >= current_request["Blue"] and potion.green >= current_request["Green"] and potion.red >= current_request["Red"]:
	var i = 0
	for color in potion.colors:
		if color < current_request.colors[i]:
			success = false
		i += 1
		
	if success:
		on_request_success()
	else:
		on_request_fail()
	
func on_request_success():
	Global.joy += customer_data.joy_on_success
	Global.anguish += customer_data.anguish_on_success
	Global.gold += customer_data.gold_reward
	var dialog = DialogManager.start_dialog(customer_data.dialog_success, global_position + dialog_offset)
	request_box.visible = false
	dialog.dialog_finished.connect(Callable(self, "_on_dialog_finished"))

func on_request_fail(): 
	Global.joy += customer_data.joy_on_fail
	Global.anguish += customer_data.anguish_on_fail
	var dialog = DialogManager.start_dialog(customer_data.dialog_fail, global_position + dialog_offset)
	request_box.visible = false
	dialog.dialog_finished.connect(Callable(self, "_on_dialog_finished"))
	
func _on_dialog_finished():
	emit_signal("finished")
	
func _type_request(text: String):
	$RequestBox/TextBox/RequestText.text = ""
	for i in range(text.length()):
		$RequestBox/TextBox/RequestText.text += text[i]
		await get_tree().create_timer(0.05).timeout
	
func show_request(potion: Potion):
	var text_node := $RequestBox/TextBox/RequestText
	text_node.clear()
	_type_request("I want: \n")
	var lines := []
	lines.append(_build_line("Blue", potion.blue, current_request.blue))
	lines.append(_build_line("Green", potion.green, current_request.green))
	lines.append(_build_line("Red", potion.red, current_request.red))
	for line in lines:
		await get_tree().create_timer(0.45).timeout
		text_node.append_text(line + "\n")
		
	
func _build_request_text(potion: Potion) -> String:
	var text: String
	var blue = _build_line("Blue", potion.blue, current_request.blue) + "\n"
	var green = _build_line("Green", potion.green, current_request.green) + "\n"
	var red = _build_line("Red", potion.red, current_request.red)
	text = "I want: \n" + blue + green + red 
	return text
	
func _build_line(color_name: String, current_amount: int, required_amount: int) -> String:
	var display_amount = min(current_amount, required_amount)
	var done := current_amount >= required_amount
	var color := '#6CCF7D' if done else "#E06C75"
	var prefix := "✔ " if done else "✖ "

	if done: return "[color=%s]%s [s]%d/%d %s[/s][/color]" % [color, prefix, display_amount, required_amount, color_name]
	else: return "[color=%s]%s %d/%d %s[/color]" % [color, prefix, display_amount, required_amount, color_name]
	
func _on_potion_changed(potion: Potion):
	$RequestBox/TextBox/RequestText.text = _build_request_text(potion)
