extends Resource
class_name Card


#region properties
@export var title : String
@export var card_art : Texture
@export_multiline var effect_text : String

@export var green_add : int = 0
@export var blue_add : int = 0
@export var red_add : int = 0

@export var energy_cost : int = 0
@export var joy_cost : int = 0
@export var anguish_cost : int = 0
@export var green_cost : int = 0
@export var blue_cost : int = 0
@export var red_cost : int = 0

#endregion

#region logic
func apply_cost():
	pass
	
func apply_numerical_effect():
	pass
	
func apply_other_effect():
	pass

#endregion
