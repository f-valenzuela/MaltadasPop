extends Node

class_name SmoothieData

enum Flavors {Green, Red, Blue, White}
@export var mixed : bool = false
@export var flavors : Array[Flavors]
@export var mix_porcentage : float

func set_mixed_parameters(new_flavors : Array[Flavors], new_mix_porcentaje : float):
	mixed = true
	
	flavors = new_flavors
	mix_porcentage = new_mix_porcentaje


enum Toppings {Empty, Green, Red, Blue, White}
enum Decorations {Empty, Green, Red, Blue, White}
@export var decorations : Decorations
@export var topped : bool
@export var toppings : Toppings
@export var distance : float

func set_toppings_parameters(new_decorations : Decorations , new_toppings : Toppings, new_distance : float):
	topped = true
	decorations = new_decorations
	toppings = new_toppings
	distance = new_distance
