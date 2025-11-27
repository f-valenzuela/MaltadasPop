@tool
extends MarginContainer

class_name SecondaryFlavorButton

const ICECREAM_CHOCOLATE = preload("uid://becrmn5goxgnh")
const ICECREAM_DULCEDELECHE = preload("uid://xmvda17lkh8m")

@export var texture_rect: TextureRect

@export var debug_mode: bool = false

@export var flavor_type: SmoothieData.SecondaryFlavorTypes
	#set(value):
		#if debug_mode == true:
			#flavor_type = value
			#set_texture(value)

signal flavor_selected(type: SmoothieData.SecondaryFlavorTypes)

func set_texture(type : SmoothieData.SecondaryFlavorTypes):
	if type == SmoothieData.SecondaryFlavorTypes.Empty:
		texture_rect.texture = null
	if type == SmoothieData.SecondaryFlavorTypes.Chocolate:
		texture_rect.texture = ICECREAM_CHOCOLATE
	if type == SmoothieData.SecondaryFlavorTypes.Dulce:
		texture_rect.texture = ICECREAM_DULCEDELECHE

func _on_pressed() -> void:
	flavor_selected.emit(flavor_type)
