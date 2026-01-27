extends MarginContainer

signal dialog_finished()

var text_to_display: Array[String] = []
var current_index: int = 0
var typing_speed: float = 0.03
var is_typing: bool = false
var current_full_text: String = ""

@onready var text_label: Label = $TextContainer/TextLabel
@onready var tween: Tween = get_tree().create_tween()

func _ready() -> void:
	print(position)
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_STOP
	focus_mode = Control.FOCUS_ALL
	grab_focus()
	pivot_offset = size/2
	self.scale = Vector2.ZERO
	tween.tween_property(self, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)
	if text_to_display.size() > 0: pass
		#show_text() 
func show_text():
	if current_index < text_to_display.size():
		is_typing = true
		current_full_text = text_to_display[current_index]
		text_label.text = ""
		_type_text(current_full_text)
	else:
		_close_dialog()
		
func _type_text(text: String):
	for i in range(text.length()):
		if !is_typing:
			return
		text_label.text += text[i]
		await get_tree().create_timer(typing_speed, true).timeout
	
	is_typing = false
	#get_tree().paused = true
	
func _close_dialog():
	is_typing = true
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_BACK)
	await tween.finished
	dialog_finished.emit()
	queue_free()
		
	
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			is_typing = false
			text_label.text = current_full_text
			return
			
		if current_index + 1 < text_to_display.size():
			current_index += 1
			show_text()
		else :
			_close_dialog()

func set_custom_minimum(new_size: Vector2):
	$TextContainer/TextLabel.custom_minimum_size = new_size
