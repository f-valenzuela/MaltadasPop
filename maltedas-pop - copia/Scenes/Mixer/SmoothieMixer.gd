extends Scene

class_name SmoothieMixer

@export_group("Nodes")
@export var ice_cream_container : Container
@export var glass_buttons_container : Control
@export var order_steps : MixerOrderSteps
@export var glass : MixerGlass
@export var secondary_ingredients_container : Container

var active : bool = false
var current_smoothie : SmoothieData

signal finished(data : SmoothieData)

func _ready() -> void:
	connect_signals()

func connect_signals():
	for child in ice_cream_container.get_children():
		if child is IceCreamButton:
			child.flavor_selected.connect(on_ice_cream_selected)
	
	for child in glass_buttons_container.get_children():
		if child is GlassButton:
			child.glass_selected.connect(on_glass_selected)
	
	for child in secondary_ingredients_container.get_children():
		if child is SecondaryFlavorButton:
			child.flavor_selected.connect(on_secondary_flavor_selected)

func on_ice_cream_selected(flavor : SmoothieData.IceCreamFlavors):
	if active:
		print("ice selected")
		glass.set_flavor(flavor)

func on_glass_selected(glass_type : SmoothieData.GlassType):
	if active:
		print("glass selected")
		glass.set_glass_type(glass_type)

func on_secondary_flavor_selected(flavor : SmoothieData.SecondaryFlavorTypes):
	if active:
		print("secondary flavor selected")
		glass.set_secondary_flavor(flavor)

func start(order_data : OrderData, smoothie : SmoothieData):
	current_smoothie = smoothie
	order_steps.set_colors(order_data)
	glass.visible = true
	glass.start(MixerGlass.Modes.Mixing, smoothie)
	active = true

func reset(order_data : OrderData, smoothie : SmoothieData):
	active = true
	current_smoothie = smoothie
	order_steps.set_colors(order_data)
	glass.visible = true
	glass.load_data(smoothie)

func on_exit():
	active = false
	glass.visible = false

func _on_glass_finished(data : SmoothieData):
	if active:
		active = false
		finished.emit(data)
