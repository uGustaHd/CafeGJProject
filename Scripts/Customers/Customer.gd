extends Node2D

@export var customer_data: CustomerData
var current_request: Potion
var dialog_intro : Array[String]
var dialog_offset: Vector2 = Vector2(0,100)
var request_text: String
var is_potion_delivered : bool = false
@onready var footstep_aproach = customer_data.footstep_aproach.pick_random()
@onready var footstep_leave = customer_data.footstep_leaving.pick_random()
#NOTE: There is an error here, it seems to not break the game. I'll leave it this way
@onready var HandHolder: PileHolder = $"../CardManager/HandHolder"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_potion : Potion

var success_fx := preload("res://Assets/Audio/FX/FX_action_7.mp3")
var fail_fx := preload("res://Assets/Audio/FX/FX_action_6.mp3")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var request_box = $RequestBox


signal finished
var died: bool = false


func setup():
	current_potion = Potion.new()
	Global.can_play_cards = false
	if customer_data != null:
		
		play_approach_audio()
		$Sprite2D.texture = customer_data.possible_sprite.pick_random()
		$Sprite2D.scale = Vector2(1.5,1.5)
		$Sprite2D.visible = false
		animation_player.play("appear_animation")
		#NOTE: Currently only generates a potion of difficulty 1 every time.
		var new_request = Potion.new()
		new_request.generate_potion(Global.get_difficulty())
		current_request = new_request
		dialog_intro = [customer_data.dialog_intro.pick_random()]
		request_box.position = position + Vector2(80,-50)
		request_box.visible = true
		show_request(Potion.new())
		
	else:
		print("No CustomerData")
func _ready() -> void:
	setup()
	Global.can_play_cards = true
	print("\nCustomer Appeared")
	var card_manager = get_tree().current_scene.get_node("CardManager")
	var potion_holder = card_manager.get_node("PotionHolder")
	card_manager.connect("potion_delivered", Callable(self, "_on_potion_delivered"))
	potion_holder.potion_progress_changed.connect(_on_potion_changed)
	await audio_stream_player_2d.finished
	await get_tree().process_frame
	DialogManager.start_dialog(dialog_intro, global_position + dialog_offset)
	#await dialog.dialog_finished

	
	
#Signal
func _on_potion_delivered(_potion : Potion) -> void:
	if !is_potion_delivered:
		#print("Potion instance id:", potion.get_instance_id())
		#print("RAW:", potion.blue, potion.green, potion.red)
		#print("ARRAY:", potion.colors)
		# NOTE: Recommend replace with check against a requested potion resource.
		# TODO: Replace request Dictionary with a RequestResource
		#if potion.blue >= current_request["Blue"] and potion.green >= current_request["Green"] and potion.red >= current_request["Red"]:
		var success := true
		for i in range(3): # 0 = blue, 1 = green, 2 = red
			var player_color = current_potion.colors[i]
			var request_color = current_request.colors[i]
			print("\nChecking color ", i, ": player=", player_color, " request=", request_color)
			if player_color < request_color:
				success = false
		if success:
			on_request_success()
		else:
			on_request_fail()
		is_potion_delivered = true
	return

func on_request_success():
	audio_stream_player_2d.stream = success_fx
	audio_stream_player_2d.play()
	var joy_anguish_meters = get_tree().current_scene.get_node("UIControl/JoyAnguishMeters")
	Global.add_joy(customer_data.joy_on_success)
	Global.add_anguish(customer_data.anguish_on_success)
	#NOTE: customer_data.gold_reward is the minimum amount of gold
	Global.add_gold(customer_data.gold_reward + randi_range(0, 8))
	var dialog = DialogManager.start_dialog(customer_data.dialog_success, global_position + dialog_offset)
	request_box.visible = false
	dialog.dialog_finished.connect(Callable(self, "_on_dialog_finished"))
	print(Global.joy)
	print(Global.anguish)
	joy_anguish_meters.update()
	Global.plesed_customers += 1
	
func on_request_fail():
	audio_stream_player_2d.stream = fail_fx
	audio_stream_player_2d.play()
	var joy_anguish_meters = get_tree().current_scene.get_node("UIControl/JoyAnguishMeters")
	Global.joy += customer_data.joy_on_fail
	Global.anguish += customer_data.anguish_on_fail
	var dialog = DialogManager.start_dialog(customer_data.dialog_fail, global_position + dialog_offset)
	request_box.visible = false
	await get_tree().process_frame
	dialog.dialog_finished.connect(Callable(self, "_on_dialog_finished"))
	print(Global.joy)
	print(Global.anguish)
	joy_anguish_meters.update()
var is_dying := false
	
func die():
	
	died = true
	HandHolder.discard_hand()
	var joy_anguish_meters = get_tree().current_scene.get_node("UIControl/JoyAnguishMeters")
	if is_dying:
		return
	is_dying = true
	Global.joy += customer_data.joy_on_kill
	Global.anguish += customer_data.anguish_on_kill
	Global.add_gold(customer_data.gold_reward + randi_range(0, 8))
	var dialog = DialogManager.start_dialog(customer_data.dialog_kill, global_position + dialog_offset)
	request_box.visible = false
	dialog.dialog_finished.connect(Callable(self, "_on_dialog_finished"))
	joy_anguish_meters.update()
	Global.killed_customers += 1
	
	
	
func _on_dialog_finished():
	$Sprite2D.visible = false
	$RequestBox.visible = false
	emit_signal("finished")
	
func show_request(potion: Potion):
	var text_node := $RequestBox/TextBox/RequestText
	text_node.clear()
	text_node.text = "I want:\n"
	var lines := []
	lines.append(_build_line("Blue", potion.blue, current_request.blue, potion.blue_multiplier))
	lines.append(_build_line("Green", potion.green, current_request.green, potion.green_multiplier))
	lines.append(_build_line("Red", potion.red, current_request.red, potion.red_multiplier))
	for line in lines:
		#await get_tree().create_timer(0.45).timeout
		text_node.append_text(line + "\n")
	
	
func _build_request_text(potion: Potion) -> String:
	var text: String
	var blue = _build_line("Blue", potion.blue, current_request.blue, potion.blue_multiplier) + "\n"
	var green = _build_line("Green", potion.green, current_request.green, potion.green_multiplier) + "\n"
	var red = _build_line("Red", potion.red, current_request.red, potion.red_multiplier)
	text = "I want: \n" + blue + green + red
	return text
	
func _build_line(color_name: String, current_amount: int, required_amount: int, multiplier: int) -> String:
	var display_amount = current_amount
	var done := current_amount >= required_amount
	var color := '#6CCF7D' if done else "#E06C75"
	var prefix := "✔ " if done else "✖ "
	var multi
	if multiplier > 1:
		multi = str(multiplier) + "x"
	elif multiplier < 0:
		multi =  "/" + str(abs(multiplier))
	else:
		multi = ""
	if done: return "[color=%s]%s [s]%d/%d %s[/s] %s[/color]" % [color, prefix, display_amount, required_amount, color_name, multi]
	else: return "[color=%s]%s %d/%d %s %s[/color]" % [color, prefix, display_amount, required_amount, color_name, multi]
	
func _on_potion_changed(potion: Potion):
	current_potion = potion
	$RequestBox/TextBox/RequestText.text = _build_request_text(potion)
	
func play_leaving_audio():
	audio_stream_player_2d.stream = footstep_leave
	audio_stream_player_2d.play()
	return audio_stream_player_2d

func play_approach_audio():
	audio_stream_player_2d.stream = footstep_aproach
	audio_stream_player_2d.play()
	return audio_stream_player_2d
