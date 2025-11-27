extends Scene

class_name SmoothieToppings

@onready var glass: Control = $Glass
@onready var glass_container: VBoxContainer = $Glass/VBoxContainer

@onready var decoration: ColorRect = $Decorations/DecorationMarker/Decoration
@onready var v_box_container: VBoxContainer = $Glass/VBoxContainer

@export_group("Nodes")
@export var decorations_container : Container
@export var toppings_node : Node2D

var current_decoration : SmoothieData.DecorationTypes = SmoothieData.DecorationTypes.Empty
var toppings : SmoothieData.ToppingTypes = SmoothieData.ToppingTypes.Empty
var distance : float

var active : bool = false

signal finished(decoration : SmoothieData.DecorationTypes, toppings : SmoothieData.ToppingTypes, distance : float)

func _ready() -> void:
	set_signals()

func set_signals():
	for child in decorations_container.get_children():
		if child is DecorationButton:
			child.decoration_selected.connect(on_decoration_selected)
	
	for child in toppings_node.get_children():
		if child is dragger:
			child.drop.connect(on_topping_drop)

func reset(current_smootie_data : SmoothieData):
	print("SmoothieToppings : active == true")
	active = true
	current_decoration = SmoothieData.DecorationTypes.Empty
	toppings = SmoothieData.ToppingTypes.Empty
	distance = 0
	
	for child in glass_container.get_children():
		child.queue_free()
	
	decoration.color = Color.TRANSPARENT
	
	fill_glass(current_smootie_data)

func fill_glass(smootie_data : SmoothieData):
	print("SmoothieToppings : loading flavors")
	for flavor : SmoothieData.IceCreamFlavors in smootie_data.flavors:
		
		match flavor:
			SmoothieData.IceCreamFlavors.Dulce:
				add_flavor(Color.GREEN)
			SmoothieData.IceCreamFlavors.Vanilla:
				add_flavor(Color.RED)
			SmoothieData.IceCreamFlavors.Chocolate:
				add_flavor(Color.BLUE)

func add_flavor(color : Color):
	print("SmoothieToppings : new color layer added", color)
	var new_color_rect := ColorRect.new()
	new_color_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_color_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
	new_color_rect.color = color
	
	v_box_container.add_child(new_color_rect)

func on_decoration_selected(new_deco : SmoothieData.DecorationTypes):
	print("SmoothieToppings : decoration selected : ", new_deco)
	if not active:
		return
	
	match new_deco:
		SmoothieData.DecorationTypes.Chocolate:
			decoration.color = Color.GREEN
			current_decoration = SmoothieData.DecorationTypes.Chocolate
		SmoothieData.DecorationTypes.Chocolate:
			decoration.color = Color.RED
			current_decoration = SmoothieData.DecorationTypes.Chocolate
		SmoothieData.DecorationTypes.Chocolate:
			decoration.color = Color.BLUE
			current_decoration = SmoothieData.DecorationTypes.Chocolate

	print("SmoothieToppings : current_decoration →", current_decoration)

func on_topping_drop(new_distance : float, topping_type : SmoothieData.ToppingTypes):
	print("SmoothieToppings : topping dropped, distance =", new_distance)
	
	toppings = topping_type
	distance = new_distance

func _on_complete_button_pressed() -> void:
	if active:
		if decoration != null or toppings != null:
			active = false
			
			print("ToppingScene : decoration == ",current_decoration, " topping == ",toppings, " topping distance == ",distance)
			
			finished.emit(current_decoration, toppings, distance)
		
