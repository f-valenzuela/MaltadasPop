extends Control

class_name ScenesUI

var camera : Camera2D

signal scene_changed(scene : SceneManager.Scenes)

func _on_counter_button_pressed() -> void:
	camera.position.y = 1920 * 0
	scene_changed.emit(SceneManager.Scenes.Counter)

func _on_mixer_button_pressed() -> void:
	camera.position.y = 1920 * 1
	scene_changed.emit(SceneManager.Scenes.Mixer)

func _on_toppings_button_pressed() -> void:
	camera.position.y = 1920 * 2
	scene_changed.emit(SceneManager.Scenes.Topping)
