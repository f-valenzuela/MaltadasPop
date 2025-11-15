extends Control

class_name Scene

@export var scenes_ui : ScenesUI

signal scene_changed(scene : SceneManager.Scenes)

func _ready() -> void:
	scenes_ui.scene_changed.connect(on_scene_changed)

func set_camera(new_camera : Camera2D) -> void:
	scenes_ui.camera = new_camera

func on_scene_changed(scene : SceneManager.Scenes):
	scene_changed.emit(scene)
