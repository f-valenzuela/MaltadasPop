extends Node2D

class_name SmoothieMixer

@onready var glass: Control = $Glass

@onready var progress_bar: ProgressBar = $Glass/ProgressBar
@onready var v_box_container: VBoxContainer = $Glass/VBoxContainer

@export var staling_speed : float = 0.1
@export var mixing_speed : float = 0.5

var value : float :
	set(new_value) :
		new_value = clamp(new_value, 0, 1)
		value = new_value

var flavors : Array[SmoothieData.Flavors]

var active : bool = false

var clicked : bool = false

signal finished (mix_value : float, flavors : Array[SmoothieData.Flavors])

func reset():
	active = true
	value = 0
	glass.visible = true
	flavors.clear()
	for child in v_box_container.get_children():
		child.queue_free()

func load_colors(smootie_data : SmoothieData):
	for e in smootie_data.flavors:
		match e:
			SmoothieData.Flavors.Green:
				add_color(Color.GREEN)
			SmoothieData.Flavors.Red:
				add_color(Color.RED)
			SmoothieData.Flavors.Blue:
				add_color(Color.BLUE)
			SmoothieData.Flavors.White:
				add_color(Color.WHITE)

func _process(delta: float) -> void:
	if active:
		if flavors.size() > 0:
			value -= staling_speed * delta
			
			if clicked:
				clicked = false
				value += mixing_speed * delta
			
			progress_bar.value = value

func _on_clicker_area_pressed() -> void:
	clicked = true

func on_flavor_selected(c : Color):
	if active:
		match c:
			Color.GREEN:
				add_color(c)
				flavors.append(SmoothieData.Flavors.Green)
			Color.RED:
				add_color(c)
				flavors.append(SmoothieData.Flavors.Red)
			Color.BLUE:
				add_color(c)
				flavors.append(SmoothieData.Flavors.Blue)
			Color.WHITE:
				add_color(c)
				flavors.append(SmoothieData.Flavors.White)

func add_color(color : Color):
	var new_color_rect := ColorRect.new()
	new_color_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_color_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
	new_color_rect.color = color
	
	v_box_container.add_child(new_color_rect)

func on_exit():
	glass.visible = false

func _on_complete_button_pressed() -> void:
	if active:
		if flavors.size() > 0: 
			active = false
			finished.emit(value, flavors)













	
