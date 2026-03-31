extends Node2D

signal customer_spawned(request_potion)

@onready var Dealer = $"../CardManager/DeckHolder/Dealer"
@onready var PotionHolder = $"../CardManager/PotionHolder"
@onready var Bell: AudioStreamPlayer2D = $Bell



@export var customer_scene: PackedScene
@export var spawn_position: Node2D
@export var spawn_delay: float = 1

var customer_per_day := 1
var customers_served_today := 0
var current_customer: Node = null

func start_day():
	customers_served_today = 0
	$"../UIControl/DayCustomerCounter".update_customer(customer_per_day, customers_served_today)
	spawn_customer()

func _ready() -> void:
	customer_spawned.connect(Dealer.on_customer_spawned)
	customer_spawned.connect(PotionHolder.on_customer_spawned)
#	var card_manager = get_tree().current_scene.get_node("CardManager")
#	card_manager.connect("deliver_potion", Callable(self, "_on_potion_delivered"))

#func _on_potion_delivered():
#	spawn_customer()

func spawn_customer():
	if customers_served_today < customer_per_day:

		Bell.play()
		#await Bell.finished
		if current_customer != null: current_customer.queue_free()
		current_customer = customer_scene.instantiate();
		get_tree().current_scene.add_child(current_customer)
		current_customer.position = spawn_position.position
		current_customer.connect("finished", Callable(self, "_on_customer_finished"))
		if Global.game_mode == Global.GameMode.NORMAL:
			customer_spawned.emit(current_customer.current_request)
		return current_customer
	else:
		if Global.game_mode == Global.GameMode.NORMAL:
			end_day()

func end_day(): 
	$"..".end_day()
	Global.end_day_check()
	Global.day += 1
	$"../UIControl/DayReport".report_day()

func _on_customer_finished():
	print("Customer Finished")
	if !current_customer.died:
		var audio = current_customer.play_leaving_audio()
		await audio.finished
	current_customer.queue_free()
	current_customer = null
	#New npc spawn delay
	customers_served_today += 1
	$"../UIControl/DayCustomerCounter".update_customer(customer_per_day, customers_served_today)
	await get_tree().create_timer(spawn_delay).timeout
	spawn_customer()


func _on_kill_button_pressed() -> void:
	if Global.can_play_cards:
		if current_customer == null : return
		if Global.kill >= 1.0:
			Global.add_kill(-1.0)
			current_customer.die()
