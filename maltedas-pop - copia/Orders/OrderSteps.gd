extends Control

class_name MixerOrderSteps

@onready var mixer_glass: MixerGlass = $MarginContainer/MixerGlass

func set_colors(order_data : OrderData):
	mixer_glass.set_glass_type(order_data.glass)
	mixer_glass.set_flavor(order_data.flavor)
	mixer_glass.set_secondary_flavor(order_data.secondary_flavor)
