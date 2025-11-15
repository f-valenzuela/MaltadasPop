extends Control

class_name OrderSteps

@onready var v_box_container: VBoxContainer = $VBoxContainer

func set_colors(oreder_data : OrderData):
	for child in v_box_container.get_children():
		child.queue_free()
	
	print(oreder_data.flavors)
	
	for e in oreder_data.flavors:
		match e:
			SmoothieData.Flavors.Green:
				fill(Color.GREEN)
			SmoothieData.Flavors.Red:
				fill(Color.RED)
			SmoothieData.Flavors.Blue:
				fill(Color.BLUE)
			SmoothieData.Flavors.White:
				fill(Color.WHITE)

func fill(c : Color):
	var new_color_rect := ColorRect.new()
	new_color_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_color_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
	new_color_rect.color = c
	
	v_box_container.add_child(new_color_rect)
