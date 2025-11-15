extends Control

class_name PointsCalculator

@onready var label: Label = $Panel/Label2

func calculate_points(order_data : OrderData, Smootie_data : SmoothieData):
	show()
	var points : int = 0
	var multiplier : float
	
	if order_data.good_active:
		multiplier = order_data.good_multiplier
	elif order_data.ok_active:
		multiplier = order_data.ok_multiplier
	elif order_data.bad_active:
		multiplier = order_data.bad_multiplier
	
	if Smootie_data.flavors == order_data.flavors:
		points += 10
	if Smootie_data.decorations == order_data.decoration:
		points += 10
	if Smootie_data.toppings == order_data.toppings:
		points += 10
	
	points -= abs(Smootie_data.distance)
	points -= (abs(order_data.mixing - Smootie_data.mix_porcentage))
	
	var final_points = max(0, points * multiplier)
	
	label.text = str(final_points)


func _on_button_pressed() -> void:
	hide()
