extends Node
@onready var submit_button = $"../CardManager/PotionHolder/SubmitButton"
@onready var slide_kill_panel: TextureRect = $"../UIControl/SlideKillPanel"
@onready var joy_anguish_meters: Control = $"../UIControl/JoyAnguishMeters"
@onready var energy_counter: TextureRect = $"../UIControl/EnergyCounter"
@onready var gold_counter: TextureRect = $"../UIControl/GoldCounter"
@onready var dealer: Node = $"../CardManager/DeckHolder/Dealer"
@onready var customer_manager: Node2D = $"../CustomerManager"
@onready var day_customer_counter: Control = $"../UIControl/DayCustomerCounter"
@onready var music_player: AudioStreamPlayer2D = $"../MusicPlayer"
@onready var ambience_potion_sound: AudioStreamPlayer2D = $"../AmbiencePotionSound"


enum TutorialStep {
	INTRO,
	CARDS,
	METERS,
	FIRST_CUSTOMER,
	GOLD,
	KILL,
	FINISHED
}
var intro_text: Array[String] = [
	"You're a witch, and this is your new potion shop",
	"But there's a catch: an evil patron watches over you, craving the suffering of others"
]


var cards_text: Array[String] = [
	"To brew potions, you use cards displayed at the bottom of the screen",
	"Each card adds Blue, Green, or Red values, and some cards have special effects"
]


var meters_text: Array[String] = [
	"These meters represent the customers' Joy and Anguish",
	"If Joy drops too low, the customers will turn against you",
	"If Anguish drops too low, your patron will come for you",
	"Your goal is to keep both in balance",
	"You also have an Energy meter. Playing cards consumes energy"
]

var first_customer_text: Array[String] = [
	"Here comes your first customer",
	"Fulfilling a request increases Joy but lowers Anguish. Failing does the opposite",
	"Once you're ready, press the Sell Potion button to deliver the potion."
]


var gold_text: Array[String] = [
	"Fulfilling customer requests earns you gold, shown at the bottom left",
	"Use gold to buy new cards for your deck",
	"The shop opens at the end of each day"
]

var kill_text: Array[String] = [
	"Sometimes, your patron demands more than just potions",
	"Killing a customer requires building up kill progress through specific cards",
	"When ready, you can kill the customer using the button on the left side of the screen",
	"This will greatly increase Anguish, but drastically reduce Joy",
	"Choose carefully when to cross this line"
]

var finish_text: Array[String] = [
	"Now that you know the basics, your first day can begin",
	"Good luck"
]

var tutorial_step := TutorialStep.INTRO

func _ready():

	if Global.game_mode == Global.GameMode.TUTORIAL:
		ambience_potion_sound.play()
		music_player.play()
		start_tutorial()
	else: queue_free()

func start_tutorial(): 
	day_customer_counter.visible = false
	submit_button.visible = false
	slide_kill_panel.visible = false
	joy_anguish_meters.visible = false
	energy_counter.visible = false
	gold_counter.visible = false
	start_step()
	
func start_step():
	match tutorial_step:
		TutorialStep.INTRO:
			show_intro()
		TutorialStep.CARDS:
			show_cards()
		TutorialStep.METERS:
			show_meters()
		TutorialStep.FIRST_CUSTOMER:
			show_customer()
		TutorialStep.GOLD:
			show_gold()
		TutorialStep.KILL:
			show_kill()
		TutorialStep.FINISHED:
			finished()

func finished():

	await get_tree().process_frame
	var dialog = DialogManager.start_dialog(finish_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	await dialog.dialog_finished
	Global.game_mode = Global.GameMode.NORMAL
	Global.day = 1
	Global.day_variables_to_zero()
	Global.joy = 50
	Global.anguish = 50
	queue_free()
	music_player.stop()
	ambience_potion_sound.stop()
	get_tree().reload_current_scene()


func show_kill():
	await get_tree().process_frame
	slide_kill_panel.visible = true
	var dialog = DialogManager.start_dialog(kill_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(advance_step)

func show_gold():
	await get_tree().process_frame
	gold_counter.visible = true
	var dialog = DialogManager.start_dialog(gold_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(advance_step)


func show_customer():
	await get_tree().process_frame
	var dialog = DialogManager.start_dialog(first_customer_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	await dialog.dialog_finished
	submit_button.visible = true
	Global.can_play_cards = true
	customer_manager.customer_per_day = 1
	var customer = customer_manager.spawn_customer()
	customer.finished.connect(advance_step)



func show_meters():
	await get_tree().process_frame
	joy_anguish_meters.visible = true
	energy_counter.visible = true
	joy_anguish_meters.update()
	var dialog = DialogManager.start_dialog(meters_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(advance_step)


func show_cards():
	await get_tree().process_frame
	dealer.deal_cards(5)
	var dialog = DialogManager.start_dialog(cards_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(advance_step)

func show_intro():
	await get_tree().process_frame
	var dialog = DialogManager.start_dialog(intro_text, get_parent().get_viewport_rect().size/2)
	dialog.set_custom_minimum(Vector2(500, 50))
	dialog.dialog_finished.connect(advance_step)

func advance_step():
	tutorial_step = (tutorial_step + 1) as TutorialStep
	start_step()
	
	
