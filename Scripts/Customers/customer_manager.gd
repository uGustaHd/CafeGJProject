extends Node2D

signal customer_spawned

@onready var Dealer = $"../CardManager/DeckHolder/Dealer"

@export var customer_scene: PackedScene
@export var spawn_position: Node2D
@export var spawn_delay: float = 3

var current_customer: Node = null

func _ready() -> void:
	customer_spawned.connect(Dealer.on_customer_spawned)
#	var card_manager = get_tree().current_scene.get_node("CardManager")
#	card_manager.connect("deliver_potion", Callable(self, "_on_potion_delivered"))

#func _on_potion_delivered():
#	spawn_customer()

func spawn_customer():
	if current_customer != null: current_customer.queue_free()
	current_customer = customer_scene.instantiate();
	get_tree().current_scene.add_child(current_customer)
	current_customer.position = spawn_position.position
	current_customer.connect("finished", Callable(self, "_on_customer_finished"))
	
	customer_spawned.emit()
	
	
func _on_customer_finished():
	print("Customer Finished")
	current_customer.queue_free()
	current_customer = null
	#New npc spawn delay
	await get_tree().create_timer(spawn_delay).timeout
	spawn_customer()


func _on_kill_button_pressed() -> void:
	if current_customer == null : return
	current_customer.die()
