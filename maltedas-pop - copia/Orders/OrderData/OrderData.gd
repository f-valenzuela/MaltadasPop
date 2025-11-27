extends Resource

class_name OrderData

## name for debug purposes
var id : int

## Name of the item to show on hover(?)
@export var name : String
## Description of item to show in on click ui, recipe book, etc(?)
@export_multiline var description : String

@export var duration : float

@export var max_puntuation : int
@export var min_puntuation : int

var current_puntuation : float

@export_group("Score multipliers")
@export_subgroup("Good")
## time window during which this multiplier is applied
@export var good_duration : float
@export var good_multiplier : float
var good_active : bool = true

@export_subgroup("ok")
## time window during which this multiplier is applied
@export var ok_duration : float
@export var ok_multiplier : float
var ok_active : bool

@export_subgroup("bad")
@export var bad_multiplier : float
var bad_active : bool

@export_group("Smoothie Parameters")
@export var glass : SmoothieData.GlassType
@export var flavor : SmoothieData.IceCreamFlavors
@export var mixed : bool = false
@export var mix_porcentage : float
@export var secondary_flavor : SmoothieData.SecondaryFlavorTypes
@export var decoration : SmoothieData.DecorationTypes
@export var decoration_amount : int
@export var topped : bool
@export var topping : SmoothieData.ToppingTypes
@export var distance : float
