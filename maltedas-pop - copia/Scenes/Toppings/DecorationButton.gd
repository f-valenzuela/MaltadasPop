@tool
extends TextureRect

class_name DecorationButton

## Dont touch
@export var decoration_texture: ColorRect

@export var current_decoration : SmoothieData.DecorationTypes : 
	set(value):
		current_decoration = value
		update_icon(current_decoration)

signal decoration_selected (new_flavor : SmoothieData.DecorationTypes)

func _ready() -> void:
	update_icon(current_decoration)

func update_icon(decoration : SmoothieData.DecorationTypes):
	print(decoration)
	match decoration:
		SmoothieData.DecorationTypes.Chocolate:
			decoration_texture.color = Color.GREEN
		SmoothieData.DecorationTypes.Chocolate:
			decoration_texture.color = Color.RED
		SmoothieData.DecorationTypes.Chocolate:
			decoration_texture.color = Color.BLUE

func _on_decoration_button_pressed() -> void:
	decoration_selected.emit(current_decoration)
