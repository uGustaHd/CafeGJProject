extends Node2D

@export var customer_scene: PackedScene
@export var spawn_position: Node2D
@export var spawn_delay: float = 3

var current_customer: Node = null


func spawn_customer():
	if current_customer != null: current_customer.queue_free()
	current_customer = customer_scene.instantiate();
	get_tree().current_scene.add_child(current_customer)
	current_customer.position = spawn_position.position
	current_customer.connect("finished", Callable(self, "_on_customer_finished"))
	
	
func _on_customer_finished():
	print("Customer Finished")
	current_customer.queue_free()
	current_customer = null
	#New npc spawn delay
	await get_tree().create_timer(spawn_delay).timeout
	spawn_customer()
