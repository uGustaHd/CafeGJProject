extends Node

var gold    : int = 0 
var joy     : float = 0
var anguish : float = 0
var day     : int = 0

func add_joy(value):
	joy += max(0, joy + value)
	
func add_anguish(value):
	anguish += max(0, anguish + value)
