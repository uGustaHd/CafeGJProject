extends Node2D

@export var customer_data: CustomerData
var current_request: Dictionary

signal finished()
signal died

func setup():
	if customer_data != null:
		$Sprite2D.texture = customer_data.sprite
		current_request = customer_data.possible_requests.pick_random()
		
	else:
		print("No CustomerData")

func _ready() -> void:
	setup()
	
	#TO-DO Connect a signal with the potion that the player gave to the NPC
	var card_manager = get_tree().current_scene.get_node("CardManager")
	card_manager.connect("item_delivered", Callable(self, "_on_cards_delivered"))
	
	#TO-DO Shows dialog box with dialog intro
	print(customer_data.dialog_intro)
	
	#TO-DO Shows dialog box with request
	print("I want \n" + str(current_request.get("Green")) + "x Green\n" + str(current_request.get("Red")) + "x Red\n" + str(current_request.get("Blue")) + "x Blue")
	
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
	emit_signal("finished")
	#TO-DO Show dialog box with success dialog
	print(customer_data.dialog_success)
func on_request_fail(): 
	Global.joy += customer_data.joy_on_fail
	Global.anguish += customer_data.anguish_on_fail
	emit_signal("finished")
	#TO-DO Show dialog box with fail dialog
	print(customer_data.dialog_fail)
