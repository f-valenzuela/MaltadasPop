extends Node

class_name OrdersManager

@onready var orders_ui: OrdersUI = $OrdersUI

@export var orders_amount : int

@export var posible_orders : Array[OrderData]

var active_orders : Array[OrderData]

var current_order_id : int = 0
var current_order_selected : Order

signal order_selected (order : Order)

func _ready() -> void:
	orders_ui.fill_order_slots(orders_amount)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		create_order()

func fill_orders():
	for e in orders_amount - active_orders.size() + 1:
		create_order()

func create_order() -> OrderData:
	var new_order : OrderData = posible_orders.pick_random().duplicate()
	
	new_order.id = current_order_id
	current_order_id += 1
	
	orders_ui.add_order(new_order)
	
	return new_order

func on_order_created(new_order : Order):
	connect_order_signals(new_order)

func connect_order_signals(order : Order):
	order.time_finished.connect(on_order_finished)

func on_order_finished(order : Order):
	active_orders.erase(order.order_data)

func _on_order_seleceted(order: Order) -> void:
	print("order selected in orders manager", order)
	if order == current_order_selected:
		pass
	else:
		order_selected.emit(order)
		current_order_selected = order










	
