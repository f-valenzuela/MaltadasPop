extends Node2D

class_name SmoothieToppings

@onready var glass: Control = $Glass

@onready var decoration: ColorRect = $Decorations/DecorationMarker/Decoration

@onready var v_box_container: VBoxContainer = $Glass/VBoxContainer

var current_decoration : SmoothieData.Decorations = SmoothieData.Decorations.Empty

var toppings : SmoothieData.Toppings = SmoothieData.Toppings.Empty
var distance : float

var active : bool = false

signal finished (decoration : SmoothieData.Decorations, toppings : SmoothieData.Toppings, distance : float)

func reset(current_smootie_data : SmoothieData):
	active = true
	current_decoration = SmoothieData.Decorations.Empty
	toppings = SmoothieData.Toppings.Empty
	distance = 0
	
	decoration.color = Color.TRANSPARENT
	
	fill_glass(current_smootie_data)

func fill_glass(smootie_data : SmoothieData):
	for e : SmoothieData.Flavors in smootie_data.flavors:
		match e:
			SmoothieData.Flavors.Green:
				flavor(Color.GREEN)
			SmoothieData.Flavors.Red:
				flavor(Color.RED)
			SmoothieData.Flavors.Blue:
				flavor(Color.BLUE)
			SmoothieData.Flavors.White:
				flavor(Color.WHITE)

func flavor(color : Color):
	var new_color_rect := ColorRect.new()
	new_color_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_color_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
	new_color_rect.color = color
	
	v_box_container.add_child(new_color_rect)

func on_decoration_selected(i : int):
	if active:
		match i:
			0:
				decoration.color = Color.GREEN
				current_decoration = SmoothieData.Decorations.Green
				pass
			1:
				decoration.color = Color.RED
				current_decoration = SmoothieData.Decorations.Red
				pass
			2:
				decoration.color = Color.BLUE
				current_decoration = SmoothieData.Decorations.Blue
				pass
			3:
				decoration.color = Color.WHITE
				current_decoration = SmoothieData.Decorations.White
				pass

func on_topping_drop(new_distance : float):
	toppings = SmoothieData.Toppings.Empty
	distance = new_distance

func _on_complete_button_pressed() -> void:
	if active:
		if decoration != null: 
			active = false
			finished.emit(current_decoration, toppings, distance)
