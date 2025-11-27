extends Control

class_name PointsCalculator

@onready var label: Label = $Panel/Label2

@export_group("Points per match")
@export var flavor_points : int = 10
@export var secondary_flavor_points : int = 5
@export var decoration_points : int = 10
@export var topping_points : int = 10
@export var glass_points : int = 5
@export var topped_points : int = 5

@export_group("Penalties")
@export var decoration_amount_penalty : float = 1.0
@export var mix_difference_penalty : float = 1.0
@export var distance_penalty : float = 1.0

func calculate_points(order_data : OrderData, smoothie_data : SmoothieData):
	show()
	
	var points : float = 0.0
	var multiplier : float = get_multiplier(order_data)
	
	if smoothie_data.flavor == order_data.flavor:
		points += flavor_points
	
	if smoothie_data.secondary_flavor == order_data.secondary_flavor:
		points += secondary_flavor_points
	
	if smoothie_data.decoration == order_data.decoration:
		points += decoration_points
	
	if smoothie_data.topping == order_data.topping:
		points += topping_points
	
	if smoothie_data.glass == order_data.glass:
		points += glass_points
	
	if smoothie_data.topped == order_data.topped:
		points += topped_points
	
	points -= abs(order_data.decoration_amount - smoothie_data.decoration_amount) * decoration_amount_penalty
	points -= abs(order_data.mix_porcentage - smoothie_data.mix_porcentage) * mix_difference_penalty
	points -= abs(order_data.distance - smoothie_data.distance) * distance_penalty
	
	label.text = str(int(points))


func get_multiplier(order_data : OrderData) -> float:
	if order_data.good_active:
		return order_data.good_multiplier
	
	if order_data.ok_active:
		return order_data.ok_multiplier
	
	return order_data.bad_multiplier

func _on_button_pressed() -> void:
	hide()
