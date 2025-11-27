extends Node2D

class_name dragger

var dragging := false
var start_position : Vector2

var radius : float = 64

@export var type : SmoothieData.ToppingTypes

signal drop(drop_position_x : float, topping_type : SmoothieData.ToppingTypes)

func _ready() -> void:
	start_position = global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_mouse_over():
				dragging = true
				#global_position = get_global_mouse_position()
			elif dragging:
				dragging = false
				drop.emit(global_position.x, type)
				return_to_start()
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position()

func return_to_start() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", start_position, 0.3)

func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	return mouse_pos.distance_to(global_position) <= radius
