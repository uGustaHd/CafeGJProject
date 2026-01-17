extends Node2D

@export var customer_data: CustomerData
var current_request: Dictionary
var dialog_offset: Vector2 = Vector2(0,110)
var request_text: String
@onready var request_box = $RequestBox

signal finished
signal died

func setup():
	if customer_data != null:
		$Sprite2D.texture = customer_data.sprite
		current_request = customer_data.possible_requests.pick_random()
		request_text = "I want \n" + str(current_request.get("Blue")) + "x Blue\n" +  str(current_request.get("Green")) + "x Green\n" + str(current_request.get("Red")) + "x Red" 
		request_box.visible = false
		request_box.position = position + Vector2(100,-50)
	else:
		print("No CustomerData")

func _ready() -> void:
	setup()
	print("\nCustomer Appeared")
	
	#TO-DO Connect a signal with the potion that the player gave to the NPC
	var card_manager = get_tree().current_scene.get_node("CardManager")
	card_manager.connect("item_delivered", Callable(self, "_on_cards_delivered"))
	
	await get_tree().process_frame
	var dialog = DialogManager.start_dialog(customer_data.dialog_intro, global_position + dialog_offset)
	await dialog.dialog_finished
	request_box.visible = true
	_type_request(request_text)
	
#Signal
func _on_cards_delivered(card_dict: Dictionary) -> void: 
	var success = true
	
	for key in current_request.keys():
		if !card_dict.has(key) || card_dict[key] < current_request[key]:
			success = false
			break
		
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
	for i in range(text.length()):
		$RequestBox/TextBox/RequestText.text += text[i]
		await get_tree().create_timer(0.05).timeout
