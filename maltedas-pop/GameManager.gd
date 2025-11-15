extends Node

@onready var scenes: SceneManager = $Scenes

@onready var smoothie_mixer: SmoothieMixer = $SmoothieManager/SmoothieMixer
@onready var smoothie_toppings: SmoothieToppings = $SmoothieManager/SmoothieToppings

@onready var order_steps: OrderSteps = $OrdersManager/OrderSteps

@onready var points_calculator: PointsCalculator = $PointsCalculator
@onready var finish_button: Button = $FinishButton

var selected_order : Order

func _on_scene_changed(scene: SceneManager.Scenes) -> void:
	print(scene)
	if scene == SceneManager.Scenes.Mixer:
		if selected_order != null:
			if selected_order.smootie_data.mixed == false:
				smoothie_mixer.reset()
				order_steps.set_colors(selected_order.order_data)
			else:
				smoothie_mixer.reset()
				smoothie_mixer.load_colors(selected_order.smootie_data)
				order_steps.set_colors(selected_order.order_data)
	
	if scene == SceneManager.Scenes.Topping:
		if selected_order != null and selected_order.smootie_data.mixed == true:
			if selected_order.smootie_data.topped == false:
				print("w")
				smoothie_toppings.reset(selected_order.smootie_data)

func on_order_selected(new_order : Order):
	selected_order = new_order
	if selected_order != null and selected_order.smootie_data.mixed == true:
		if selected_order.smootie_data.topped == true:
			finish_button.show()

func _on_smoothie_mixer_finished(mix_value: float, flavors: Array[SmoothieData.Flavors]) -> void:
	if selected_order:
		selected_order.smootie_data.set_mixed_parameters(flavors, mix_value)

func _on_smootie_toppings_finished(decoration : SmoothieData.Decorations, toppings : SmoothieData.Toppings, distance : float):
	if selected_order:
		selected_order.smootie_data.set_toppings_parameters(decoration, toppings, distance)
		finish_button.show()

func _on_finish_button_pressed() -> void:
	if selected_order:
		points_calculator.calculate_points(selected_order.order_data, selected_order.smootie_data)
		finish_button.hide()
		selected_order.time_finished.emit(selected_order)
