@tool
extends TextureRect

class_name IceCreamButton

const ICECREAM_CHOCOLATE_TEXTURE = preload("uid://becrmn5goxgnh")
const ICECREAM_DULCEDELECHE_TEXTURE = preload("uid://xmvda17lkh8m")
const ICECREAM_VANILLA_TEXTURE = preload("uid://de8h54yydf17b")

signal flavor_selected (new_flavor : SmoothieData.IceCreamFlavors)

@export var ice_cream_texture : TextureRect

@export var current_flavor : SmoothieData.IceCreamFlavors : 
	set(value):
		current_flavor = value
		update_icon(value)

func _ready() -> void:
	update_icon(current_flavor)

func update_icon(ice_cream : SmoothieData.IceCreamFlavors):
	match ice_cream:
		SmoothieData.IceCreamFlavors.Dulce:
			ice_cream_texture.texture = ICECREAM_DULCEDELECHE_TEXTURE
		SmoothieData.IceCreamFlavors.Vanilla:
			ice_cream_texture.texture = ICECREAM_VANILLA_TEXTURE
		SmoothieData.IceCreamFlavors.Chocolate:
			ice_cream_texture.texture = ICECREAM_CHOCOLATE_TEXTURE

func _on_ice_cream_button_pressed() -> void:
	flavor_selected.emit(current_flavor)
