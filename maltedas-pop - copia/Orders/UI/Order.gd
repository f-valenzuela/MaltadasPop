extends NinePatchRect

class_name Order

@export var progress_bar: ProgressBar
@export var order_texture: TextureRect

@onready var mixer_glass: MixerGlass = $VBoxContainer2/Control/VBoxContainer/MixerGlass

var order_data : OrderData
var smootie_data : SmoothieData

var duration : float
var time : float

var started : bool

signal good_time_started
signal ok_time_started
signal bad_time_started
signal time_finished (order : Order)

signal selected (order : Order)

func _ready() -> void:
	progress_bar.max_value = 1

func _process(delta: float) -> void:
	if started:
		update_time(delta)

func start(new_order_data : OrderData):
	smootie_data = SmoothieData.new()
	started = true
	configure_order(new_order_data)
	
	order_data.good_active = true
	good_time_started.emit()

func configure_order(new_order_data : OrderData):
	order_data = new_order_data
	duration = order_data.duration
	
	#order_texture.texture = order_data.texture
	mixer_glass.set_glass_type(order_data.glass)
	mixer_glass.set_flavor(order_data.flavor)
	mixer_glass.set_secondary_flavor(order_data.secondary_flavor)

func update_time(delta : float):
	time += delta
	
	var normal_time = normalize_time(time)
	
	progress_bar.value = normal_time
	
	compare_time(normal_time)

func normalize_time(new_time : float) -> float:
	return remap(new_time, 0, duration, 0, 1)

func compare_time(current_time : int):
	if current_time >= 1:
		time_finished.emit(self)
	
	if order_data.good_active:
		if current_time > order_data.good_duration:
			order_data.good_active = false
			order_data.ok_active = true
			emit_signal("ok_time_started")
	
	elif order_data.ok_active:
		if current_time > order_data.ok_duration:
			order_data.ok_active = false
			order_data.bad_active = true
			emit_signal("bad_time_started")
	
	elif order_data.bad_active:
		pass  

func get_multiplier(current_time : float) -> float:
	var multiplier : float
	if current_time <= normalize_time(order_data.good_duration):
		multiplier = order_data.good_multiplier
	
	elif current_time <= normalize_time(order_data.ok_duration):
		multiplier = order_data.ok_multiplier
	
	else:
		multiplier = order_data.bad_multiplier
	
	return multiplier

func _on_debug_button_pressed() -> void:
	print("order seleced in order", self)
	selected.emit(self)




	
