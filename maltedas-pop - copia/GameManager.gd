extends Node

@export_group("Nodes")
@export var smoothie_counter : CounterScene
@export var smoothie_mixer : SmoothieMixer
@export var smoothie_toppings: SmoothieToppings

@onready var points_calculator: PointsCalculator = $PointsCalculator
@onready var finish_button: Button = $FinishButton

var selected_order : Order

func _on_scene_changed(scene: SceneManager.Scenes) -> void:
	print("GameManager : scene == ", scene)
	if scene == SceneManager.Scenes.Mixer:
		if selected_order != null:
			print(selected_order)
			smoothie_mixer.start(selected_order.order_data, selected_order.smootie_data)
	
	if scene == SceneManager.Scenes.Topping:
		print(1)
		if selected_order != null and selected_order.smootie_data.mixed == true:
			print(2)
			if selected_order.smootie_data.topped == false:
				print(3)
				smoothie_toppings.reset(selected_order.smootie_data)

func on_order_selected(new_order : Order):
	selected_order = new_order
	if selected_order != null and selected_order.smootie_data.mixed == true:
		if selected_order.smootie_data.topped == true:
			finish_button.show()

@warning_ignore("unused_parameter")
func _on_smoothie_mixer_finished(data : SmoothieData) -> void:
	if selected_order:
		if selected_order.smootie_data.mixed == true:
			finish_button.show()

func _on_smootie_toppings_finished(decoration : SmoothieData.DecorationTypes, toppings : SmoothieData.ToppingTypes, distance : float):
	if selected_order:
		print(selected_order.smootie_data.mixed)
		selected_order.smootie_data.set_toppings_parameters(decoration, toppings, distance)
		finish_button.show()

func _on_finish_button_pressed() -> void:
	if selected_order:
		print("mixed : ", selected_order.smootie_data.mixed)
		print("flavors : ", selected_order.smootie_data.flavor)
		print("mix_porcentage : ", selected_order.smootie_data.mix_porcentage)
		print("decorations : ", selected_order.smootie_data.decoration)
		print("topped : ", selected_order.smootie_data.topped)
		print("toppings : ", selected_order.smootie_data.topping )
		print("distance : ", selected_order.smootie_data.distance)
		points_calculator.calculate_points(selected_order.order_data, selected_order.smootie_data)
		finish_button.hide()
		selected_order.time_finished.emit(selected_order)


func _on_orders_manager_order_errased() -> void:
	smoothie_counter.destroy_human()


func _on_orders_manager_order_created() -> void:
	smoothie_counter.create_human()
