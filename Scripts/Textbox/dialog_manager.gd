extends Node

@export var dialog_scene: PackedScene
var dialog_box = null
var is_showing_dialog: bool = false

func start_dialog(text: Array[String], dialog_position: Vector2):
	if dialog_box != null and dialog_box.is_inside_tree():
		dialog_box.queue_free()
		is_showing_dialog = false
	
	if is_showing_dialog:
		return null
	
	if dialog_scene:
		dialog_box = dialog_scene.instantiate()
		get_tree().current_scene.add_child(dialog_box)
		dialog_box.text_to_display = text
		dialog_box.global_position = dialog_position
		dialog_box.show_text()
		is_showing_dialog = true
		
		dialog_box.dialog_finished.connect(_on_dialog_finished)
		return dialog_box
	
	return null
	
func _on_dialog_finished():
	is_showing_dialog = false
	#if dialog_box:
	#dialog_box.queue_free()
	dialog_box = null
	
func reset() -> void:
	dialog_box = null
	is_showing_dialog = false
