extends Node

class_name SmoothieData

enum GlassType {Empty, Simple, Complete}
enum IceCreamFlavors {Empty, Dulce, Vanilla, Chocolate}
enum DecorationTypes {Empty, Chocolate, Cookie, Mani}
enum ToppingTypes {Empty, Cake, Brownie, Cookie, Oreo}
enum SecondaryFlavorTypes {Empty, Chocolate, Dulce}

@export var glass : GlassType

@export var flavor : IceCreamFlavors
@export var mixed : bool = false
@export var mix_porcentage : float

@export var secondary_flavor : SecondaryFlavorTypes

@export var decoration : DecorationTypes
@export var decoration_amount : int

@export var topped : bool
@export var topping : ToppingTypes
@export var distance : float

func set_mixed_parameters(new_flavor : IceCreamFlavors, new_mix_porcentaje : float):
	mixed = true
	
	flavor = new_flavor
	mix_porcentage = new_mix_porcentaje

func set_toppings_parameters(new_decoration : DecorationTypes , new_topping : ToppingTypes, new_distance : float):
	topped = true
	decoration = new_decoration
	topping = new_topping
	distance = new_distance
