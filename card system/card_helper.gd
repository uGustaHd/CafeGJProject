extends Node

# NOTE: Global may become irrelevant with new card_tool script

#func _ready() -> void:
	#await get_tree().process_frame
	#preload("res://card system/card resources/blue/water.tres")
	#ready_card_resources()
#
#func ready_card_resources() -> void:
	#var card_folders : Array[String] = [
		#"res://card system/card resources/blue/",
		#"res://card system/card resources/gold/",
		#"res://card system/card resources/green/",
		#"res://card system/card resources/purple/",
		#"res://card system/card resources/rainbow/",
		#"res://card system/card resources/red/",
	#]
	#for path in card_folders: 
		#var dir = DirAccess.open(path)
		#if dir:
			#dir.list_dir_begin()
			#var file_name = dir.get_next()
			#while file_name != "":
				#if dir.current_is_dir():
					#print_debug("Found directory: " + file_name)
				#else:
					#print_debug("Found file: " + file_name)
					#var loaded_item : Card = load(path + file_name)
					#loaded_item.add_effect_resources()
					#loaded_item.add_cost_resources()
				#file_name = dir.get_next()
		#else:
			#print("An error occurred when trying to access the path.")
