extends Control

class_name OrdersUI

@onready var h_box: HBoxContainer = $HBoxContainer2

const ORDER = preload("uid://c14lo4mj2gtws")
const ORDER_SLOT = preload("uid://bhgl8mmfvle6v")

var orders_slots : Array[OrderSlot]

signal order_created (new_order : Order)
signal order_seleceted (order : Order)

func fill_order_slots(amount : int): 
	for e in range(amount): 
		var new_order_slot : OrderSlot = create_order_slot() 
		new_order_slot.used = false

func create_order_slot() -> OrderSlot:
	var new_order_slot : OrderSlot = ORDER_SLOT.instantiate()
	
	h_box.add_child(new_order_slot)
	
	orders_slots.append(new_order_slot)
	
	return new_order_slot

func destroy_order_slot(slot : OrderSlot):
	orders_slots.erase(slot)
	slot.queue_free()

func add_order(order : OrderData = null):
	for slot in orders_slots:
		if slot.used == false:
			var new_order = create_order()
			
			slot.add_child(new_order)
			slot.used = true
			slot.order = new_order
			
			if order:
				new_order.start(order)
			
			return

func create_order() -> Order:
	var new_order : Order = ORDER.instantiate()
	
	new_order.time_finished.connect(on_order_finished)
	new_order.selected.connect(on_order_selected)
	
	order_created.emit(new_order)
	
	return new_order

func on_order_finished(order : Order):
	destroy_order_slot(order.get_parent())
	create_order_slot()

func on_order_selected(order : Order):
	print("order selected in orders ui", order)
	order_seleceted.emit(order)





	
