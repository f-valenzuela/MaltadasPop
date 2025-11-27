extends Control

class_name ScenesUI

var camera : Camera2D

signal scene_changed(scene : SceneManager.Scenes)

func _on_counter_button_pressed() -> void:
	scene_changed.emit(SceneManager.Scenes.Counter)

func _on_mixer_button_pressed() -> void:
	scene_changed.emit(SceneManager.Scenes.Mixer)

func _on_toppings_button_pressed() -> void:
	scene_changed.emit(SceneManager.Scenes.Topping)
